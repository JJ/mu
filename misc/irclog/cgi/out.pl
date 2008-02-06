#!/usr/bin/perl
use warnings;
use strict;
use Carp qw(confess);
use CGI::Carp qw(fatalsToBrowser);
use Date::Simple qw(date);
use Encode::Guess;
use CGI;
use Encode;
use HTML::Template;
use Config::File;
use File::Slurp;
use lib 'lib';
use IrcLog qw(get_dbh gmt_today);
use IrcLog::WWW qw(http_header message_line my_encode);
use Cache::FileCache;
#use Data::Dumper;


# Configuration
# $base_url is the absoulte URL to the directoy where index.pl and out.pl live
# If they live in the root of their own virtual host, set it to "/".
my $conf = Config::File::read_config_file('cgi.conf');
my $base_url = $conf->{BASE_URL} || q{/};
print http_header();

# I'm too lazy right to move this to  a config file, because Config::File seems
# unable to handle arrays, just hashes.

# map nicks to CSS classes.
my @colors = (
        ['TimToady',    'nick_timtoady'],
        ['audreyt',     'nick_audreyt'],
        ['evalbot',     'bots'],
        ['exp_evalbot', 'bots'],
        ['lambdabot',   'bots'],
        ['pugs_svnbot', 'bots'],
        ['pugs_svn',    'bots'],
        ['specbot',     'bots'],
        ['pasteling',   'bots'],
        ['rakudo_svn',  'bots'],
        ['purl',        'bots'],
        ['svnbotlt',    'bots'],
         );
# additional classes for nicks, sorted by frequency of speech:
my @nick_classes = map { "nick$_" } (1 .. 9);

# Default channel: this channel will be shown if no channel=... arg is given
my $default_channel = 'perl6';

# End of config

my $q = new CGI;
my $dbh = get_dbh();
my $channel = $q->param('channel') || $default_channel;
my $date = $q->param('date') || gmt_today();
if ($date eq 'today') {
    $date = gmt_today();
}


if ($channel !~ m/\A\w+\z/smx){
    # guard against channel=../../../etc/passwd or so
    confess 'Invalid channel name';
}

my $cache_key = $channel . '|' . $date;
if ($date eq gmt_today()){
    # no caching here
    print irclog_output($date, $channel);
} else {
    my $cache = new Cache::FileCache( { 
            namespace 		=> 'irclog',
            } );
    my $data = $cache->get($cache_key);
    if (defined $data){
        print $data;
    } else {
        $data = irclog_output($date, $channel);
        $cache->set($cache_key, $data, '1 day');
        print $data;
    }
}

sub irclog_output {
    my ($date, $channel) = @_;

    my $full_channel = q{#} . $channel;
    my $t = HTML::Template->new(
            filename            => 'template/day.tmpl',
            loop_context_vars   => 1,
            global_vars         => 1,
            );

    $t->param(ADMIN => 1) if ($q->param('admin'));

    {
        my $clf = "channels/$channel.tmpl";
        if (-e $clf) {
            $t->param(CHANNEL_LINKS => q{} . read_file($clf));
        }
    }
    $t->param(BASE_URL  => $base_url);
    my $self_url = $base_url . "/$channel/$date";
    my $db = $dbh->prepare('SELECT id, nick, timestamp, line FROM irclog '
            . 'WHERE day = ? AND channel = ? AND NOT spam ORDER BY id');
    $db->execute($date, $full_channel);


# determine which colors to use for which nick:
    {
        my $count = scalar @nick_classes + scalar @colors + 1;
        my $q1 = $dbh->prepare('SELECT nick, COUNT(nick) AS c FROM irclog'
                . ' WHERE day = ? AND channel = ? AND not spam'
                . " GROUP BY nick ORDER BY c DESC LIMIT $count");
        $q1->execute($date, $full_channel);
        while (my @row = $q1->fetchrow_array and @nick_classes){
            next unless length $row[0];
            my $n = quotemeta $row[0];
            unless (grep { $_->[0] =~ m/\A$n/smx } @colors){
                push @colors, [$row[0], shift @nick_classes];
            }
        }
#    $t->param(DEBUG => Dumper(\@colors));
    }

    my @msg;

    my $line = 1;
    my $prev_nick = q{};
    my $c = 0;

# populate the template
    my $line_number = 0;
    while (my @row = $db->fetchrow_array){
        my $id = $row[0];
        my $nick = decode('utf8', ($row[1]));
        my $timestamp = $row[2];
        my $message = $row[3];

        push @msg, message_line( {
                id           => $id,
                nick        => $nick,
                timestamp   => $timestamp,
                message     => $message,
                line_number =>  ++$line_number,
                prev_nick   => $prev_nick,
                colors      => \@colors,
                self_url    => $self_url,
                channel     => $channel,
                },
                \$c,
                );
        $prev_nick = $nick;
    }

    $t->param(
            CHANNEL     => $channel,
            MESSAGES    => \@msg,
            DATE        => $date,
        );

# check if previous/next date exists in database
    {
        my $q1 = $dbh->prepare('SELECT COUNT(*) FROM irclog '
                . 'WHERE channel = ? AND day = ? AND NOT spam');
        # Date::Simple magic ;)
        my $tomorrow = date($date) + 1;
        $q1->execute($full_channel, $tomorrow);
        my ($res) = $q1->fetchrow_array();
        if ($res){
            $t->param(NEXT_URL => $base_url . "$channel/$tomorrow");
        }

        my $yesterday = date($date) - 1;
        $q1->execute($full_channel, $yesterday);
        ($res) = $q1->fetchrow_array();
        if ($res){
            $t->param(PREV_URL => $base_url . "$channel/$yesterday");
        }

    }

    return my_encode($t->output);
}


# vim: sw=4 ts=4 expandtab
