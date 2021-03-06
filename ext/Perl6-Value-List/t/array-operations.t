use v6;
use Test;

plan 28;
force_todo <4 5 6 7 8 16 17>;
 
use Perl6::Value::List;

{
  # string range
  my $iter = Perl6::Value::List.from_range( start => 'a', end => Inf, step => undef );
  is( $iter.shift, 'a', 'string range' );  
  is( $iter.shift, 'b', 'string range 1' );
}

{
  # 'Iter' object
  my $span = Perl6::Value::List.from_range( start => 0, end => 13, step => 1 );

  my $grepped = $span.to_list.Perl6::Value::List::grep:{ $_ % 3 == 0 };
  is( $grepped.shift, 0, 'grep  ' );  
  is( $grepped.shift, 3, 'grep 0' );

  my $mapped = $grepped.map:{ $_ % 6 == 0 ?? ($_, $_) !! () };
  is( $mapped.shift,  6, 'map 0' );
  is( try{ $mapped.shift },  6, 'map 1' );
  is( try{ $mapped.shift }, 12, 'map 0' );
  is( try{ $mapped.shift }, 12, 'map 1' );

  is( try{ $mapped.shift }, undef, 'end' );
}

{
  # coroutine
  
  my coro mylist { yield $_ for 1..2; yield; }
  
  my $a1 = Perl6::Value::List.from_coro( &mylist ); 
  is( $a1.shift, 1, 'lazy array from coroutine' );
  is( $a1.shift, 2, 'coroutine' );
  is( $a1.shift, undef, 'coroutine end' );
  is( $a1.shift, undef, 'coroutine really ended' );
}

{
  # kv
  
  my coro mylist { yield $_ for 4..5; yield; }
  
  my $a1 = Perl6::Value::List.new( cstart => &mylist ); 
  $a1 = $a1.kv;
  is( $a1.shift, 0, 'kv' );
  is( $a1.shift, 4, 'kv' );
  is( $a1.shift, 1, 'kv' );
  is( $a1.shift, 5, 'kv' );
}

{
  # pairs
  
  my coro mylist { yield $_ for 4..5; yield; }
  
  my $a1 = Perl6::Value::List.new( cstart => &mylist ); 
  $a1 = $a1.pairs;
  my $p = $a1.shift;
  is( ~($p.WHAT),  'Pair',     'pair' );
  is( $p.perl, '(0 => 4)', 'pair' );
}

{
  # zip
  
  my $a1 = Perl6::Value::List.from_range( start => 4, end => 5 ); 
  
  my coro mylist2 { yield $_ for 1..3; yield; }
  my $a2 = Perl6::Value::List.new( cstart => &mylist2 ); 
  
  $a1 = $a1.Perl6::Value::List::zip( $a2 );
  is( try {$a1.shift}, 4, 'zip' );
  is( try {$a1.shift}, 1, 'zip' );
  is( try {$a1.shift}, 5, 'zip' );
  is( try {$a1.shift}, 2, 'zip' );
  is( try {$a1.shift}, undef, 'zip' );
  # is( try {$a1.shift}, 3, 'zip' );    # list exhausted == end of zip
  is( try {$a1.shift}, undef, 'zip' );
  is( try {$a1.shift}, undef, 'zip' );
}

{
  # elems
  my $iter = Perl6::Value::List.from_range( start => 1, end => 1000000, step => 2 );
  is( $iter.Perl6::Value::List::elems, 500000, 'Lazy List elems' );

  is( $iter.kv.Perl6::Value::List::elems, 1000000, 'Lazy List elems doubles after kv()' );
}
