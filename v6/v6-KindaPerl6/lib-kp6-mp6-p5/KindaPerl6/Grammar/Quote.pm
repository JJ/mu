# Do not edit this file - Generated by MiniPerl6
use v5;
use strict;
use MiniPerl6::Perl5::Runtime;
use MiniPerl6::Perl5::Match;
package KindaPerl6::Grammar;
sub new { shift; bless { @_ }, "KindaPerl6::Grammar" }
sub double_quoted { my $grammar = shift; my $List__ = \@_; my $str; my $pos; do {  $str = $List__->[0];  $pos = $List__->[1]; [$str, $pos] }; my  $MATCH; $MATCH = MiniPerl6::Perl5::Match->new( 'str' => $str,'from' => $pos,'to' => $pos,'bool' => 1, ); $MATCH->bool(do { my  $pos1 = $MATCH->to(); (do { (do { my  $tmp = $MATCH; $MATCH = MiniPerl6::Perl5::Match->new( 'str' => $str,'from' => $tmp->to(),'to' => $tmp->to(),'bool' => 1, ); $MATCH->bool(do { my  $pos1 = $MATCH->to(); (do { (('\\' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) } || (do { $MATCH->to($pos1); (('\'' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) } || (do { $MATCH->to($pos1); (('"' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) } || (do { $MATCH->to($pos1); (('$' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) } || (do { $MATCH->to($pos1); (('@' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) } || do { $MATCH->to($pos1); (('%' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) }))))) }); $tmp->bool(($MATCH ? 0 : 1)); $MATCH = $tmp; ($MATCH ? 1 : 0) } && ((('' ne substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && do { my  $m2 = $grammar->double_quoted($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'double_quoted'} = $m2;1 } else { 0 } } })) } || do { $MATCH->to($pos1); 1 }) }); return($MATCH) };
sub quoted_any { my $grammar = shift; my $List__ = \@_; my $str; my $pos; do {  $str = $List__->[0];  $pos = $List__->[1]; [$str, $pos] }; my  $MATCH; $MATCH = MiniPerl6::Perl5::Match->new( 'str' => $str,'from' => $pos,'to' => $pos,'bool' => 1, ); $MATCH->bool(do { my  $pos1 = $MATCH->to(); do { (('' ne substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) } }); return($MATCH) };
sub quoted_array { my $grammar = shift; my $List__ = \@_; my $str; my $pos; do {  $str = $List__->[0];  $pos = $List__->[1]; [$str, $pos] }; my  $MATCH; $MATCH = MiniPerl6::Perl5::Match->new( 'str' => $str,'from' => $pos,'to' => $pos,'bool' => 1, ); $MATCH->bool(do { my  $pos1 = $MATCH->to(); do { (do { my  $tmp = $MATCH; $MATCH = MiniPerl6::Perl5::Match->new( 'str' => $str,'from' => $tmp->to(),'to' => $tmp->to(),'bool' => 1, ); $MATCH->bool(do { my  $pos1 = $MATCH->to(); do { (('@' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) } }); $tmp->bool(($MATCH ? 1 : 0)); $MATCH = $tmp; ($MATCH ? 1 : 0) } && (do { my  $m2 = $grammar->var($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'var'} = $m2;1 } else { 0 } } } && ((('[' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && (do { my  $m2 = $grammar->opt_ws($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());1 } else { 0 } } } && (((']' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && do { my  $ret = sub  { my $List__ = \@_; do { [] }; do { return(Apply->new( 'code' => Var->new( 'sigil' => '&','twigil' => '','name' => 'prefix:<~>','namespace' => [], ),'arguments' => [${$MATCH->{'var'}}], )) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);$MATCH->bool(1);return($MATCH) } else {  } }; 1 }))))) } }); return($MATCH) };
sub quoted_hash { my $grammar = shift; my $List__ = \@_; my $str; my $pos; do {  $str = $List__->[0];  $pos = $List__->[1]; [$str, $pos] }; my  $MATCH; $MATCH = MiniPerl6::Perl5::Match->new( 'str' => $str,'from' => $pos,'to' => $pos,'bool' => 1, ); $MATCH->bool(do { my  $pos1 = $MATCH->to(); do { (do { my  $tmp = $MATCH; $MATCH = MiniPerl6::Perl5::Match->new( 'str' => $str,'from' => $tmp->to(),'to' => $tmp->to(),'bool' => 1, ); $MATCH->bool(do { my  $pos1 = $MATCH->to(); do { (('%' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) } }); $tmp->bool(($MATCH ? 1 : 0)); $MATCH = $tmp; ($MATCH ? 1 : 0) } && (do { my  $m2 = $grammar->var($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'var'} = $m2;1 } else { 0 } } } && ((('{' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && (do { my  $m2 = $grammar->opt_ws($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());1 } else { 0 } } } && ((('}' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && do { my  $ret = sub  { my $List__ = \@_; do { [] }; do { return(Apply->new( 'code' => Var->new( 'sigil' => '&','twigil' => '','name' => 'prefix:<~>','namespace' => [], ),'arguments' => [${$MATCH->{'var'}}], )) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);$MATCH->bool(1);return($MATCH) } else {  } }; 1 }))))) } }); return($MATCH) };
sub quoted_scalar { my $grammar = shift; my $List__ = \@_; my $str; my $pos; do {  $str = $List__->[0];  $pos = $List__->[1]; [$str, $pos] }; my  $MATCH; $MATCH = MiniPerl6::Perl5::Match->new( 'str' => $str,'from' => $pos,'to' => $pos,'bool' => 1, ); $MATCH->bool(do { my  $pos1 = $MATCH->to(); do { (do { my  $tmp = $MATCH; $MATCH = MiniPerl6::Perl5::Match->new( 'str' => $str,'from' => $tmp->to(),'to' => $tmp->to(),'bool' => 1, ); $MATCH->bool(do { my  $pos1 = $MATCH->to(); do { (('$' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) } }); $tmp->bool(($MATCH ? 1 : 0)); $MATCH = $tmp; ($MATCH ? 1 : 0) } && (do { my  $m2 = $grammar->var($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'var'} = $m2;1 } else { 0 } } } && do { my  $ret = sub  { my $List__ = \@_; do { [] }; do { return(Apply->new( 'code' => Var->new( 'sigil' => '&','twigil' => '','name' => 'prefix:<~>','namespace' => [], ),'arguments' => [${$MATCH->{'var'}}], )) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);$MATCH->bool(1);return($MATCH) } else {  } }; 1 })) } }); return($MATCH) };
sub quoted_exp { my $grammar = shift; my $List__ = \@_; my $str; my $pos; do {  $str = $List__->[0];  $pos = $List__->[1]; [$str, $pos] }; my  $MATCH; $MATCH = MiniPerl6::Perl5::Match->new( 'str' => $str,'from' => $pos,'to' => $pos,'bool' => 1, ); $MATCH->bool(do { my  $pos1 = $MATCH->to(); (do { (do { my  $m2 = $grammar->quoted_array($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'quoted_array'} = $m2;1 } else { 0 } } } && do { my  $ret = sub  { my $List__ = \@_; do { [] }; do { return(${$MATCH->{'quoted_array'}}) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);$MATCH->bool(1);return($MATCH) } else {  } }; 1 }) } || (do { $MATCH->to($pos1); (do { my  $m2 = $grammar->quoted_hash($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'quoted_hash'} = $m2;1 } else { 0 } } } && do { my  $ret = sub  { my $List__ = \@_; do { [] }; do { return(${$MATCH->{'quoted_hash'}}) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);$MATCH->bool(1);return($MATCH) } else {  } }; 1 }) } || (do { $MATCH->to($pos1); (do { my  $m2 = $grammar->quoted_scalar($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'quoted_scalar'} = $m2;1 } else { 0 } } } && do { my  $ret = sub  { my $List__ = \@_; do { [] }; do { return(${$MATCH->{'quoted_scalar'}}) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);$MATCH->bool(1);return($MATCH) } else {  } }; 1 }) } || (do { $MATCH->to($pos1); ((('\'' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && do { my  $ret = sub  { my $List__ = \@_; do { [] }; do { return(Val::Char->new( 'char' => 39, )) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);$MATCH->bool(1);return($MATCH) } else {  } }; 1 }) } || (do { $MATCH->to($pos1); ((('\\' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && do { my  $pos1 = $MATCH->to(); (do { ((('a' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && do { my  $ret = sub  { my $List__ = \@_; do { [] }; do { return(Val::Char->new( 'char' => 7, )) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);$MATCH->bool(1);return($MATCH) } else {  } }; 1 }) } || (do { $MATCH->to($pos1); ((('b' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && do { my  $ret = sub  { my $List__ = \@_; do { [] }; do { return(Val::Char->new( 'char' => 8, )) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);$MATCH->bool(1);return($MATCH) } else {  } }; 1 }) } || (do { $MATCH->to($pos1); ((('t' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && do { my  $ret = sub  { my $List__ = \@_; do { [] }; do { return(Val::Char->new( 'char' => 9, )) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);$MATCH->bool(1);return($MATCH) } else {  } }; 1 }) } || (do { $MATCH->to($pos1); ((('n' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && do { my  $ret = sub  { my $List__ = \@_; do { [] }; do { return(Val::Char->new( 'char' => 10, )) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);$MATCH->bool(1);return($MATCH) } else {  } }; 1 }) } || (do { $MATCH->to($pos1); ((('f' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && do { my  $ret = sub  { my $List__ = \@_; do { [] }; do { return(Val::Char->new( 'char' => 12, )) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);$MATCH->bool(1);return($MATCH) } else {  } }; 1 }) } || (do { $MATCH->to($pos1); ((('r' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && do { my  $ret = sub  { my $List__ = \@_; do { [] }; do { return(Val::Char->new( 'char' => 13, )) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);$MATCH->bool(1);return($MATCH) } else {  } }; 1 }) } || (do { $MATCH->to($pos1); ((('e' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && do { my  $ret = sub  { my $List__ = \@_; do { [] }; do { return(Val::Char->new( 'char' => 27, )) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);$MATCH->bool(1);return($MATCH) } else {  } }; 1 }) } || (do { $MATCH->to($pos1); ((('"' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && do { my  $ret = sub  { my $List__ = \@_; do { [] }; do { return(Val::Char->new( 'char' => 34, )) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);$MATCH->bool(1);return($MATCH) } else {  } }; 1 }) } || (do { $MATCH->to($pos1); ((('\'' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && do { my  $ret = sub  { my $List__ = \@_; do { [] }; do { return(Val::Char->new( 'char' => 39, )) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);$MATCH->bool(1);return($MATCH) } else {  } }; 1 }) } || (do { $MATCH->to($pos1); ((('\\' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && do { my  $ret = sub  { my $List__ = \@_; do { [] }; do { return(Val::Char->new( 'char' => 92, )) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);$MATCH->bool(1);return($MATCH) } else {  } }; 1 }) } || do { $MATCH->to($pos1); (do { my  $m2 = $grammar->quoted_any($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'quoted_any'} = $m2;1 } else { 0 } } } && do { my  $ret = sub  { my $List__ = \@_; do { [] }; do { return(Val::Buf->new( 'buf' => ${$MATCH->{'quoted_any'}}, )) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);$MATCH->bool(1);return($MATCH) } else {  } }; 1 }) })))))))))) }) } || do { $MATCH->to($pos1); (do { my  $pos1 = $MATCH->to(); (do { (('$' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) } || (do { $MATCH->to($pos1); (('@' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) } || (do { $MATCH->to($pos1); (('%' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) } || do { $MATCH->to($pos1); 1 }))) } && (do { my  $m2 = $grammar->double_quoted($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'double_quoted'} = $m2;1 } else { 0 } } } && do { my  $ret = sub  { my $List__ = \@_; do { [] }; do { return(Val::Buf->new( 'buf' => ("" . $MATCH), )) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);$MATCH->bool(1);return($MATCH) } else {  } }; 1 })) }))))) }); return($MATCH) };
sub quoted_exp_seq { my $grammar = shift; my $List__ = \@_; my $str; my $pos; do {  $str = $List__->[0];  $pos = $List__->[1]; [$str, $pos] }; my  $MATCH; $MATCH = MiniPerl6::Perl5::Match->new( 'str' => $str,'from' => $pos,'to' => $pos,'bool' => 1, ); $MATCH->bool(do { my  $pos1 = $MATCH->to(); do { (do { my  $m2 = $grammar->quoted_exp($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'quoted_exp'} = $m2;1 } else { 0 } } } && do { my  $pos1 = $MATCH->to(); (do { (do { my  $tmp = $MATCH; $MATCH = MiniPerl6::Perl5::Match->new( 'str' => $str,'from' => $tmp->to(),'to' => $tmp->to(),'bool' => 1, ); $MATCH->bool(do { my  $pos1 = $MATCH->to(); do { (('"' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) } }); $tmp->bool(($MATCH ? 1 : 0)); $MATCH = $tmp; ($MATCH ? 1 : 0) } && do { my  $ret = sub  { my $List__ = \@_; do { [] }; do { return(${$MATCH->{'quoted_exp'}}) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);$MATCH->bool(1);return($MATCH) } else {  } }; 1 }) } || do { $MATCH->to($pos1); (do { my  $m2 = $grammar->quoted_exp_seq($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'quoted_exp_seq'} = $m2;1 } else { 0 } } } && do { my  $ret = sub  { my $List__ = \@_; do { [] }; do { return(Apply->new( 'code' => Var->new( 'sigil' => '&','twigil' => '','name' => 'infix:<~>','namespace' => [], ),'arguments' => [${$MATCH->{'quoted_exp'}}, ${$MATCH->{'quoted_exp_seq'}}], )) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);$MATCH->bool(1);return($MATCH) } else {  } }; 1 }) }) }) } }); return($MATCH) };
sub single_quoted { my $grammar = shift; my $List__ = \@_; my $str; my $pos; do {  $str = $List__->[0];  $pos = $List__->[1]; [$str, $pos] }; my  $MATCH; $MATCH = MiniPerl6::Perl5::Match->new( 'str' => $str,'from' => $pos,'to' => $pos,'bool' => 1, ); $MATCH->bool(do { my  $pos1 = $MATCH->to(); (do { ((('\\' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && ((('' ne substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && do { my  $m2 = $grammar->single_quoted($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'single_quoted'} = $m2;1 } else { 0 } } })) } || (do { $MATCH->to($pos1); (do { my  $tmp = $MATCH; $MATCH = MiniPerl6::Perl5::Match->new( 'str' => $str,'from' => $tmp->to(),'to' => $tmp->to(),'bool' => 1, ); $MATCH->bool(do { my  $pos1 = $MATCH->to(); do { (('\'' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) } }); $tmp->bool(($MATCH ? 0 : 1)); $MATCH = $tmp; ($MATCH ? 1 : 0) } && ((('' ne substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && do { my  $m2 = $grammar->single_quoted($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'single_quoted'} = $m2;1 } else { 0 } } })) } || do { $MATCH->to($pos1); 1 })) }); return($MATCH) };
sub val_buf { my $grammar = shift; my $List__ = \@_; my $str; my $pos; do {  $str = $List__->[0];  $pos = $List__->[1]; [$str, $pos] }; my  $MATCH; $MATCH = MiniPerl6::Perl5::Match->new( 'str' => $str,'from' => $pos,'to' => $pos,'bool' => 1, ); $MATCH->bool(do { my  $pos1 = $MATCH->to(); (do { ((('"' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && (do { my  $m2 = $grammar->quoted_exp_seq($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'quoted_exp_seq'} = $m2;1 } else { 0 } } } && ((('"' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && do { my  $ret = sub  { my $List__ = \@_; do { [] }; do { return(${$MATCH->{'quoted_exp_seq'}}) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);$MATCH->bool(1);return($MATCH) } else {  } }; 1 }))) } || do { $MATCH->to($pos1); ((('\'' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && (do { my  $m2 = $grammar->single_quoted($str, $MATCH->to()); do { if ($m2) { $MATCH->to($m2->to());$MATCH->{'single_quoted'} = $m2;1 } else { 0 } } } && ((('\'' eq substr($str, $MATCH->to(), 1)) ? (1 + $MATCH->to((1 + $MATCH->to()))) : 0) && do { my  $ret = sub  { my $List__ = \@_; do { [] }; do { return(Val::Buf->new( 'buf' => ("" . $MATCH->{'single_quoted'}), )) }; '974^213' }->(); do { if (($ret ne '974^213')) { $MATCH->capture($ret);$MATCH->bool(1);return($MATCH) } else {  } }; 1 }))) }) }); return($MATCH) }


;
1;
