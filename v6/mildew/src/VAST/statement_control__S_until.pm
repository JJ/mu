use v5.10;
use MooseX::Declare;
use utf8;
class VAST::statement_control__S_until {
    use AST::Helpers;
    method emit_m0ld {
        AST::While->new(cond => fcall('&not' => [$self->{xblock}{EXPR}->emit_m0ld]), body => call('postcircumfix:( )',code($self->{xblock}{pblock}{blockoid}),[capturize([])])); 
    }

}
