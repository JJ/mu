use v6-alpha;
use MiniPerl6::Grammar;
use MiniPerl6::Emitter;
use MiniPerl6::Grammar::Regex;
use MiniPerl6::Emitter::Token;

my $p = MiniPerl6::Grammar.exp( 'say 1+1' );
# say ($$p).perl;
say ($$p).emit;
