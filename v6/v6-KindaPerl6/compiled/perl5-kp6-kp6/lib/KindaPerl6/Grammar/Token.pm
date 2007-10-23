# Do not edit this file - Generated by MiniPerl6
use v5;
use strict;
use MiniPerl6::Perl5::Runtime;
use MiniPerl6::Perl5::Match;

package KindaPerl6::Grammar;
sub new { shift; bless {@_}, "KindaPerl6::Grammar" }

sub token_p5_modifier {
    my $grammar = shift;
    my $List__  = \@_;
    my $str;
    my $pos;
    do { $str = $List__->[0]; $pos = $List__->[1]; [ $str, $pos ] };
    my $MATCH;
    $MATCH = MiniPerl6::Perl5::Match->new( 'str' => $str, 'from' => $pos, 'to' => $pos, 'bool' => 1, );
    $MATCH->bool(
        do {
            my $pos1 = $MATCH->to();
            (   do { ( ( ':P5' eq substr( $str, $MATCH->to(), 3 ) ) ? ( 1 + $MATCH->to( ( 3 + $MATCH->to() ) ) ) : 0 ) }
                    || do { $MATCH->to($pos1); ( ( ':Perl5' eq substr( $str, $MATCH->to(), 6 ) ) ? ( 1 + $MATCH->to( ( 6 + $MATCH->to() ) ) ) : 0 ) }
            );
            }
    );
    return ($MATCH);
}

sub token_p5_body {
    my $grammar = shift;
    my $List__  = \@_;
    my $str;
    my $pos;
    do { $str = $List__->[0]; $pos = $List__->[1]; [ $str, $pos ] };
    my $MATCH;
    $MATCH = MiniPerl6::Perl5::Match->new( 'str' => $str, 'from' => $pos, 'to' => $pos, 'bool' => 1, );
    $MATCH->bool(
        do {
            my $pos1 = $MATCH->to();
            (   do {
                    (   ( ( '\\' eq substr( $str, $MATCH->to(), 1 ) ) ? ( 1 + $MATCH->to( ( 1 + $MATCH->to() ) ) ) : 0 ) && (
                            ( ( '' ne substr( $str, $MATCH->to(), 1 ) ) ? ( 1 + $MATCH->to( ( 1 + $MATCH->to() ) ) ) : 0 ) && do {
                                my $m2 = $grammar->token_p5_body( $str, $MATCH->to() );
                                do {
                                    if ($m2) { $MATCH->to( $m2->to() ); $MATCH->{'token_p5_body'} = $m2; 1 }
                                    else {0}
                                    }
                            }
                        )
                    );
                    }
                    || (
                    do {
                        $MATCH->to($pos1);
                        (   do {
                                my $tmp = $MATCH;
                                $MATCH = MiniPerl6::Perl5::Match->new( 'str' => $str, 'from' => $tmp->to(), 'to' => $tmp->to(), 'bool' => 1, );
                                $MATCH->bool(
                                    do {
                                        my $pos1 = $MATCH->to();
                                        do { ( ( '}' eq substr( $str, $MATCH->to(), 1 ) ) ? ( 1 + $MATCH->to( ( 1 + $MATCH->to() ) ) ) : 0 ) }
                                        }
                                );
                                $tmp->bool( ( $MATCH ? 0 : 1 ) );
                                $MATCH = $tmp;
                                ( $MATCH ? 1 : 0 );
                                }
                                && (
                                ( ( '' ne substr( $str, $MATCH->to(), 1 ) ) ? ( 1 + $MATCH->to( ( 1 + $MATCH->to() ) ) ) : 0 ) && do {
                                    my $m2 = $grammar->token_p5_body( $str, $MATCH->to() );
                                    do {
                                        if ($m2) { $MATCH->to( $m2->to() ); $MATCH->{'token_p5_body'} = $m2; 1 }
                                        else {0}
                                        }
                                }
                                )
                        );
                    }
                    || do { $MATCH->to($pos1); 1 }
                    )
            );
            }
    );
    return ($MATCH);
}

sub token_P5 {
    my $grammar = shift;
    my $List__  = \@_;
    my $str;
    my $pos;
    do { $str = $List__->[0]; $pos = $List__->[1]; [ $str, $pos ] };
    my $MATCH;
    $MATCH = MiniPerl6::Perl5::Match->new( 'str' => $str, 'from' => $pos, 'to' => $pos, 'bool' => 1, );
    $MATCH->bool(
        do {
            my $pos1 = $MATCH->to();
            do {
                (   ( ( 't' eq substr( $str, $MATCH->to(), 1 ) ) ? ( 1 + $MATCH->to( ( 1 + $MATCH->to() ) ) ) : 0 ) && (
                        ( ( 'o' eq substr( $str, $MATCH->to(), 1 ) ) ? ( 1 + $MATCH->to( ( 1 + $MATCH->to() ) ) ) : 0 ) && (
                            ( ( 'k' eq substr( $str, $MATCH->to(), 1 ) ) ? ( 1 + $MATCH->to( ( 1 + $MATCH->to() ) ) ) : 0 ) && (
                                ( ( 'e' eq substr( $str, $MATCH->to(), 1 ) ) ? ( 1 + $MATCH->to( ( 1 + $MATCH->to() ) ) ) : 0 ) && (
                                    ( ( 'n' eq substr( $str, $MATCH->to(), 1 ) ) ? ( 1 + $MATCH->to( ( 1 + $MATCH->to() ) ) ) : 0 ) && (
                                        do {
                                            my $m2 = $grammar->ws( $str, $MATCH->to() );
                                            do {
                                                if ($m2) { $MATCH->to( $m2->to() ); 1 }
                                                else {0}
                                                }
                                        }
                                        && (do {
                                                my $m2 = $grammar->opt_name( $str, $MATCH->to() );
                                                do {
                                                    if ($m2) { $MATCH->to( $m2->to() ); $MATCH->{'opt_name'} = $m2; 1 }
                                                    else {0}
                                                    }
                                            }
                                            && (do {
                                                    my $m2 = $grammar->opt_ws( $str, $MATCH->to() );
                                                    do {
                                                        if ($m2) { $MATCH->to( $m2->to() ); 1 }
                                                        else {0}
                                                        }
                                                }
                                                && (do {
                                                        my $m2 = $grammar->token_p5_modifier( $str, $MATCH->to() );
                                                        do {
                                                            if ($m2) { $MATCH->to( $m2->to() ); $MATCH->{'token_p5_modifier'} = $m2; 1 }
                                                            else {0}
                                                            }
                                                    }
                                                    && (do {
                                                            my $m2 = $grammar->opt_ws( $str, $MATCH->to() );
                                                            do {
                                                                if ($m2) { $MATCH->to( $m2->to() ); 1 }
                                                                else {0}
                                                                }
                                                        }
                                                        && (( ( '{' eq substr( $str, $MATCH->to(), 1 ) ) ? ( 1 + $MATCH->to( ( 1 + $MATCH->to() ) ) ) : 0 ) && (
                                                                do {
                                                                    my $m2 = $grammar->token_p5_body( $str, $MATCH->to() );
                                                                    do {
                                                                        if ($m2) { $MATCH->to( $m2->to() ); $MATCH->{'token_p5_body'} = $m2; 1 }
                                                                        else {0}
                                                                        }
                                                                }
                                                                && (( ( '}' eq substr( $str, $MATCH->to(), 1 ) ) ? ( 1 + $MATCH->to( ( 1 + $MATCH->to() ) ) ) : 0 ) && do {
                                                                        my $ret = sub {
                                                                            my $List__ = \@_;
                                                                            do { [] };
                                                                            do { return ( Token->new( 'name' => ${ $MATCH->{'opt_name'} }, 'regex' => P5Token->new( 'regex' => ${ $MATCH->{'token_p5_body'} }, ), 'sym' => (undef), ) ) };
                                                                            '974^213';
                                                                            }
                                                                            ->();
                                                                        do {
                                                                            if ( ( $ret ne '974^213' ) ) { $MATCH->capture($ret); $MATCH->bool(1); return ($MATCH) }
                                                                            else { }
                                                                        };
                                                                        1;
                                                                    }
                                                                )
                                                            )
                                                        )
                                                    )
                                                )
                                            )
                                        )
                                    )
                                )
                            )
                        )
                    )
                );
                }
            }
    );
    return ($MATCH);
}

1;
