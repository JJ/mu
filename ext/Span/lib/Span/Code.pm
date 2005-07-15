use v6;

=for TODO

    * elements can be spans

    * compare

    * size - accept a function; use as_list

    * as_list

    * contains

    * remove "arbitrary_limit" if possible

    * include Span::Code in Span.pm API 
    
    * stringify - test with 2-5 elements 
    * document that stringify doesn't show all elements
    
    * set_start / set_end
   
    * remove "difference()" method
    
=cut

class Span::Code-0.01
{
    has Code $.closure_next;
    has Code $.closure_previous;
    has Span::Code $.universe;   

    has Code $.complement_next;
    has Code $.complement_previous;

    has $:arbitrary_limit;

submethod BUILD ( $.closure_next, $.closure_previous, ?$is_universe, ?$complement_next, ?$complement_previous, ?$.universe ) {
    # TODO - get rid of "$:arbitrary_limit"
    $:arbitrary_limit = 100;
    
    if $is_universe {
        # $.universe = $self --> $self doesn't exist yet
        $.complement_next =     sub { +Inf } unless defined $.complement_next;
        $.complement_previous = sub { -Inf } unless defined $.complement_previous;
    }
}

method stringify () {
    my @start;
    my @end;
    my $samples = 3;
    my $tmp = -Inf;
    for ( 1 .. $samples ) {
        $tmp = $.closure_next( $tmp );
        push @start, $tmp;
    }
    $tmp = Inf;
    for ( 0 .. $samples ) {
        $tmp = $.closure_previous( $tmp );
        unshift @end, $tmp;
    }
    return '' if @start[0] > @end[-1];
    return @start[0] if @start[0] == @end[-1];
    # if @start and @end intersect, don't print ".."
    if @end[0] == any( @start ) {
        push @start, @end;
        return @start.uniq.join(',');
    }
    shift @end;
    return @start.uniq.join(',') ~ '..' ~ @end.uniq.join(',');
}

method size () returns Object {
    # TODO - not lazy
    # TODO - empty set
    return undef;
}

method is_empty ($self: ) {
    return ! defined( $self.start );
}

method density () returns Object {
    # TODO - maybe undef is ok
    return undef;
}

method start () {
    my $tmp = $.closure_next( -Inf );
    return $tmp == Inf ?? undef :: $tmp;
}

method end () {
    my $tmp = $.closure_previous( Inf );
    return $tmp == -Inf ?? undef :: $tmp;
}

# the "empty set" test is done by Span.pm
method start_is_closed () { return bool::true }
method start_is_open   () { return bool::false }
method end_is_closed   () { return bool::true }
method end_is_open     () { return bool::false }

method compare ($self: $span is copy) returns int { 
    # TODO - this is hard
    ...
}

method contains ($self: $span is copy) returns bool {
    ...
}

method intersects ($self: $span is copy) returns bool {
    # TODO - optimize
    my $tmp = $self.intersection( $span );
    return ! $tmp.is_empty;
}

sub _create_and ( $closure1, $closure2, $direction ) {
    return sub ( $x is copy ) {
        my $n1 = &{ $closure1 }( $x );
        my $n2 = &{ $closure2 }( $x );
        return ( $n1 <=> $n2 ) == $direction ?? $n1 :: $n2;
    }
}

sub _create_nand ( $closure1, $closure2, $closure3, $closure4 ) {

    # XXX - use a global or object setting
    my $arbitrary_limit = 100;

    return sub ( $x is copy ) {
        my $n1;
        my $n2 = &{ $closure3 }( $x );
        for ( 0 .. $arbitrary_limit )
        {
            $n1 = &{ $closure1 }( &{ $closure2 }( $n2 ) );
            return $n1 if $n1 == $n2;
            $n2 = &{ $closure3 }( &{ $closure4 }( $n1 ) );
        }
        warn "Arbitrary limit exceeded when calculating union()";
    }
}

sub _create_intersection ( $self, $span ) {
    my $start = $span.start;
    my $end =   $span.end;
    my $start_is_open = $span.start_is_open;
    my $end_is_open =   $span.end_is_open;
    return  
        sub ( $x is copy ) {
                $x = &{ $self.closure_next }( $x );  
                if $x < $start && ! $start_is_open {
                    $x = &{ $self.closure_next }( &{ $self.closure_previous }( $start ) );
                }
                elsif $x <= $start && $start_is_open {
                    $x = &{ $self.closure_next }( $start );
                }
                if $x > $end && ! $end_is_open {
                    $x = Inf;
                }
                elsif $x >= $end && $end_is_open {
                    $x = Inf;
                }
                return $x;
            },
        sub ( $x is copy ) {
                $x = &{ $self.closure_previous }( $x );
                if $x > $end && ! $end_is_open {
                    $x = &{ $self.closure_previous }( &{ $self.closure_next }( $end ) );
                }
                elsif $x >= $end && $end_is_open {
                    $x = &{ $self.closure_previous }( $end );
                }
                if $x < $start && ! $start_is_open {
                    $x = -Inf;
                }
                elsif $x <= $start && $start_is_open {
                    $x = -Inf;
                }
                return $x;
            };
}

method union ($self: $span is copy) { 
    return $self.new( 
        closure_next =>        _create_and( $self.closure_next, $span.closure_next, -1 ),
        closure_previous =>    _create_and( $self.closure_previous, $span.closure_previous, 1 ),
        complement_next =>     _create_nand( $self.complement_next, $self.complement_previous, $span.complement_next, $span.complement_previous ),
        complement_previous => _create_nand( $self.complement_previous, $self.complement_next, $span.complement_previous, $span.complement_next ),
        universe => $self.get_universe,
    )
}

method intersection ($self: $span is copy) {

    if ( $span.isa( 'Span::Num' ) || $span.isa( 'Span::Int' ) )
    {
        my @complement = $span.complement;
        if ( @complement.elems == 0 ) {
            return $self;            
        }
        my $universe = $self.get_universe;
        my ( $closure_next, $closure_previous ) = _create_intersection( $self, $span );
        if ( @complement.elems == 1 ) {
            my ( $complement_next, $complement_previous ) = _create_intersection( $universe, @complement[0] );           
            return $self.new(
                    closure_next =>        $closure_next,
                    closure_previous =>    $closure_previous,
                    complement_next =>     $complement_next,
                    complement_previous => $complement_previous,
                );
        }
        my ( $complement_next1, $complement_previous1 ) = _create_intersection( $universe, @complement[0] );
        my ( $complement_next2, $complement_previous2 ) = _create_intersection( $universe, @complement[1] );
        return $self.new(
                closure_next =>        $closure_next,
                closure_previous =>    $closure_previous,
                complement_next =>     _create_and( $complement_next1, $complement_next2, -1 ),
                complement_previous => _create_and( $complement_previous1, $complement_previous2, 1 ),
            )
    }
    return $self.new( 
        closure_next =>        _create_nand( $self.closure_next, $self.closure_previous, $span.closure_next, $span.closure_previous ),
        closure_previous =>    _create_nand( $self.closure_previous, $self.closure_next, $span.closure_previous, $span.closure_next ),
        complement_next =>     _create_and( $self.complement_next, $span.complement_next, -1 ),
        complement_previous => _create_and( $self.complement_previous, $span.complement_previous, 1 ),
        universe => $self.get_universe,
    )
}

method complement ($self: ) {
    return $self.new( 
        closure_next =>        &{ $self.get_complement_next }, 
        closure_previous =>    &{ $self.get_complement_previous }, 
        complement_next =>     &{ $self.closure_next },
        complement_previous => &{ $self.closure_previous },
        universe =>            $self.get_universe,
    );
}

# TODO - move this to Span.pm
method difference ($self: $span ) {
    return $self.intersection( $span.complement );
}

method next ( $x ) { 
    return $.closure_next( $x );
}

method previous ( $x ) { 
    return $.closure_previous( $x );
}

submethod get_complement_next ($self: ) { 
    return $.complement_next if defined $.complement_next;
    $self.get_universe;
    return $.complement_next =
        sub ( $x is copy ) {
            for ( 0 .. $:arbitrary_limit )
            {
                $x = &{ $.universe.closure_next }( $x );
                return $x if $x == Inf ||
                             $x != &{ $self.closure_previous }( &{ $self.closure_next }( $x ) );
            }
            warn "Arbitrary limit exceeded when calculating complement()";
        };
}

submethod get_complement_previous ($self: ) { 
    return $.complement_previous if defined $.complement_previous;
    $self.get_universe;
    return $.complement_previous =
        sub ( $x is copy ) {
            for ( 0 .. $:arbitrary_limit )
            {
                $x = &{ $.universe.closure_previous }( $x );
                return $x if $x == -Inf ||
                             $x != &{ $self.closure_next }( &{ $self.closure_previous }( $x ) );
            }
            warn "Arbitrary limit exceeded when calculating complement()";
        };
}

submethod get_universe ($self: ) {
    # TODO - weak reference
    return $.universe = $self unless defined $.universe;
    return $.universe;
}

} # class Span::Code


=kwid

= NAME

Span::Code - An object representing a recurrence set

= SYNOPSIS

    use Span::Code;

    # all integer numbers
    $universe = Span::Code.new( 
        closure_next =>     sub { $_ + 1 },
        closure_previous => sub { $_ - 1 },
        :is_universe(1) );

    # all even integers
    $even_numbers = Span::Code.new( 
        closure_next =>     sub { 2 * int( $_ / 2 ) + 2     },
        closure_previous => sub { 2 * int( ( $_ - 2 ) / 2 ) },
        universe => $universe );

    # all odd integers
    $odd_numbers = $even_numbers.complement;

`:is_universe` must be set if this span is a "universal set".
Otherwise the program will emit warnings during execution, 
because it will try to find a "complement set" that doesn't exist:
the complement set of the universe is an empty set.

The complement set may also be specified with a recurrence:

    # all non-zero integers
    $non_zero = Span::Code.new( 
        closure_next =>        sub ($x) { $x == -1 ??  1 :: $x + 1 },
        closure_previous =>    sub ($x) { $x ==  1 ?? -1 :: $x - 1 },
        complement_next =>     sub ($x) { $x < 0   ??  0 ::    Inf },
        complement_previous => sub ($x) { $x > 0   ??  0 ::   -Inf },
    );

= AUTHOR

Flavio S. Glock, <fglock@pucrs.br>

= COPYRIGHT

Copyright (c) 2005, Flavio S. Glock.  All rights reserved.

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
