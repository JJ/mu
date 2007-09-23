use v6-alpha;

###########################################################################
###########################################################################

module Muldis::DB::Interface-0.4.0 {
    # Note: This given version applies to all of this file's packages.

###########################################################################

sub new_dbms of Muldis::DB::Interface::DBMS
        (Str :$engine_name!, Any :$dbms_config!) {

    die q{new_dbms(): Bad :$engine_name arg; it is not an object of a}
            ~ q{ Str-doing class, or it is the empty string.}
        if !$engine_name.defined or !$engine_name.does(Str)
            or $engine_name eq q{};

    # A module may be loaded due to it being embedded in a non-excl file.
    if (!::($engine_name).does(Module)) {
        # Note: We have to invoke this 'require' in an eval string
        # because we need the bareword semantics, where 'require'
        # will munge the module name into file system paths.
        eval "require $engine_name;";
        if (my $err = $!) {
            die q{new_dbms(): Could not load Muldis DB Engine module}
                ~ qq{ '$engine_name': $err};
        }
#        die qq{new_dbms(): Could not load Muldis DB Engine module}
#                ~ qq{ '$engine_name': while that file did compile without}
#                ~ q{ errors, it did not declare the same-named module.}
#            if !::($engine_name).does(Module);
    }
#    die qq{new_dbms(): The Muldis DB Engine module '$engine_name' does}
#            ~ q{ not provide the new_dbms() constructor function.}
#        if !::($engine_name).HOW.can('new_dbms');
    my $dbms = undef;
    try {
        $dbms = &::($engine_name)::new_dbms( :dbms_config($dbms_config) );
    };
    if (my $err = $!) {
        die qq{new_dbms(): The Muldis DB Engine module '$engine_name'}
            ~ qq{ threw an exception during its new_dbms() exec: $err};
    }
    die q{new_dbms(): The new_dbms() constructor function of the}
            ~ qq{ Muldis DB Engine module '$engine_name' did not return an}
            ~ q{ object of a Muldis::DB::Interface::DBMS-doing class.}
        if !$dbms.defined or !$dbms.does(::Muldis::DB::Interface::DBMS);

    return $dbms;
}

###########################################################################

} # module Muldis::DB::Interface

###########################################################################
###########################################################################

role Muldis::DB::Interface::DBMS {

    method new_var {
        die q{not implemented by subclass } ~ self.WHAT;
    }

    method assoc_vars {
        die q{not implemented by subclass } ~ self.WHAT;
    }

    method new_func_binding {
        die q{not implemented by subclass } ~ self.WHAT;
    }

    method assoc_func_bindings {
        die q{not implemented by subclass } ~ self.WHAT;
    }

    method new_proc_binding {
        die q{not implemented by subclass } ~ self.WHAT;
    }

    method assoc_proc_bindings {
        die q{not implemented by subclass } ~ self.WHAT;
    }

    method call_func {
        die q{not implemented by subclass } ~ self.WHAT;
    }

    method call_proc {
        die q{not implemented by subclass } ~ self.WHAT;
    }

    method trans_nest_level {
        die q{not implemented by subclass } ~ self.WHAT;
    }

    method start_trans {
        die q{not implemented by subclass } ~ self.WHAT;
    }

    method commit_trans {
        die q{not implemented by subclass } ~ self.WHAT;
    }

    method rollback_trans {
        die q{not implemented by subclass } ~ self.WHAT;
    }

} # role Muldis::DB::Interface::DBMS

###########################################################################
###########################################################################

role Muldis::DB::Interface::Var {

    method assoc_dbms {
        die q{not implemented by subclass } ~ self.WHAT;
    }

    method decl_type {
        die q{not implemented by subclass } ~ self.WHAT;
    }

    method fetch_ast {
        die q{not implemented by subclass } ~ self.WHAT;
    }

    method store_ast {
        die q{not implemented by subclass } ~ self.WHAT;
    }

} # role Muldis::DB::Interface::Var

###########################################################################
###########################################################################

role Muldis::DB::Interface::FuncBinding {

    method assoc_dbms {
        die q{not implemented by subclass } ~ self.WHAT;
    }

    method bind_func {
        die q{not implemented by subclass } ~ self.WHAT;
    }

    method bound_func {
        die q{not implemented by subclass } ~ self.WHAT;
    }

    method bind_result {
        die q{not implemented by subclass } ~ self.WHAT;
    }

    method bound_result {
        die q{not implemented by subclass } ~ self.WHAT;
    }

    method bind_params {
        die q{not implemented by subclass } ~ self.WHAT;
    }

    method bound_params {
        die q{not implemented by subclass } ~ self.WHAT;
    }

    method call {
        die q{not implemented by subclass } ~ self.WHAT;
    }

} # role Muldis::DB::Interface::FuncBinding

###########################################################################
###########################################################################

role Muldis::DB::Interface::ProcBinding {

    method assoc_dbms {
        die q{not implemented by subclass } ~ self.WHAT;
    }

    method bind_proc {
        die q{not implemented by subclass } ~ self.WHAT;
    }

    method bound_proc {
        die q{not implemented by subclass } ~ self.WHAT;
    }

    method bind_upd_params {
        die q{not implemented by subclass } ~ self.WHAT;
    }

    method bound_upd_params {
        die q{not implemented by subclass } ~ self.WHAT;
    }

    method bind_ro_params {
        die q{not implemented by subclass } ~ self.WHAT;
    }

    method bound_ro_params {
        die q{not implemented by subclass } ~ self.WHAT;
    }

    method call {
        die q{not implemented by subclass } ~ self.WHAT;
    }

} # role Muldis::DB::Interface::ProcBinding

###########################################################################
###########################################################################

=pod

=encoding utf8

=head1 NAME

Muldis::DB::Interface -
Common public API for Muldis DB Engines

=head1 VERSION

This document describes Muldis::DB::Interface version 0.4.0 for Perl 6.

It also describes the same-number versions for Perl 6 of
Muldis::DB::Interface::DBMS ("DBMS"), Muldis::DB::Interface::Var ("Var"),
Muldis::DB::Interface::FuncBinding ("FuncBinding"), and
Muldis::DB::Interface::ProcBinding ("ProcBinding").

=head1 SYNOPSIS

This simple example declares two Perl variables containing relation data,
then does a (N-ary) relational join (natural inner join) on them, producing
a third Perl variable holding the relation data of the result.

    use Muldis::DB::Interface;

    my $dbms = Muldis::DB::Interface::new_dbms(
        :engine_name('Muldis::DB::Engine::Example'),
        :dbms_config({}),
    );

    my $r1 = $dbms.new_var( :decl_type('sys.Core.Relation.Relation') );
    my $r2 = $dbms.new_var( :decl_type('sys.Core.Relation.Relation') );

    $r1.store_ast( :ast([ 'Relation', 'sys.Core.Relation.Relation', [
        {
            'x' => [ 'PInt', 'perl_pint', 4 ],
            'y' => [ 'PInt', 'perl_pint', 7 ],
        },
        {
            'x' => [ 'PInt', 'perl_pint', 3 ],
            'y' => [ 'PInt', 'perl_pint', 2 ],
        },
    ] ]) );

    $r2.store_ast( :ast([ 'Relation', 'sys.Core.Relation.Relation', [
        {
            'y' => [ 'PInt', 'perl_pint', 5 ],
            'z' => [ 'PInt', 'perl_pint', 6 ],
        },
        {
            'y' => [ 'PInt', 'perl_pint', 2 ],
            'z' => [ 'PInt', 'perl_pint', 1 ],
        },
        {
            'y' => [ 'PInt', 'perl_pint', 2 ],
            'z' => [ 'PInt', 'perl_pint', 4 ],
        },
    ] ]) );

    my $r3 = $dbms.call_func(
        :func_name('sys.Core.Relation.join'),
        :args({
            'topic' => [ 'QuasiSet', 'sys.Core.Spec.QuasiSetOfRelation', [
                $r1,
                $r2,
            ] ],
        }),
    );

    my $r3_ast = $r3.fetch_ast();

    # Then $r3_ast contains:
    # [ 'Relation', 'sys.Core.Relation.Relation', [
    #     {
    #         'x' => [ 'PInt', 'perl_pint', 3 ],
    #         'y' => [ 'PInt', 'perl_pint', 2 ],
    #         'z' => [ 'PInt', 'perl_pint', 1 ],
    #     },
    #     {
    #         'x' => [ 'PInt', 'perl_pint', 3 ],
    #         'y' => [ 'PInt', 'perl_pint', 2 ],
    #         'z' => [ 'PInt', 'perl_pint', 4 ],
    #     },
    # ] ]

For most examples of using Muldis DB, and tutorials, please see the
separate L<Muldis::DB::Cookbook> distribution (when that comes to exist).

=head1 DESCRIPTION

B<Muldis::DB::Interface>, aka I<Interface>, comprises the minimal core of
the Muldis DB framework, the one component that probably every program
would use.  Together with the Muldis D language (see L<Language::MuldisD>),
it defines the common API for Muldis DB implementations to do and which
applications invoke.

I<This documentation is pending.>

=head1 INTERFACE

The interface of Muldis::DB::Interface is fundamentally object-oriented;
you use it by creating objects from its member classes (or more
specifically, of implementing subclasses of its member roles) and then
invoking methods on those objects.  All of their attributes are private, so
you must use accessor methods.

To aid portability of your applications over multiple implementing Engines,
the normal way to create Interface objects is by invoking a
constructor-wrapping method of some other object that would provide context
for it; since you generally don't have to directly invoke any package
names, you don't need to change your code when the package names change due
to switching the Engine.  You only refer to some Engine's root package name
once, as a C<Muldis::DB::Interface::new_dbms> argument, and even that can
be read from a config file rather than being hard-coded in your
application.

The usual way that Muldis::DB::Interface indicates a failure is to throw an
exception; most often this is due to invalid input.  If an invoked routine
simply returns, you can assume that it has succeeded, even if the return
value is undefined.

=head2 The Muldis::DB::Interface Module

The C<Muldis::DB::Interface> module is the stateless root package by way of
which you access the whole Muldis DB API.  That is, you use it to load
engines and instantiate virtual machines, which provide the rest of the
Muldis DB API.

=over

=item C<new_dbms of Muldis::DB::Interface::DBMS (Str :$engine_name!, Any
:$dbms_config!)>

This constructor function creates and returns a C<DBMS> object that is
implemented by the Muldis DB Engine named by its named argument
C<$engine_name>; that object is initialized using the C<$dbms_config>
argument.  The named argument C<$engine_name> is the name of a Perl module
that is expected to be the root package of a Muldis DB Engine, and which is
expected to declare a C<new_dbms> subroutine with a single named argument
C<$dbms_config>; invoking this subroutine is expected to return an object
of some class of the same Engine which does the Muldis::DB::Interface::DBMS
role.  This function will start by testing if the root package is already
loaded (it may be declared by some already-loaded file of another name),
and only if not, will it do a Perl 'require' of the C<$engine_name>.

=back

=head2 The Muldis::DB::Interface::DBMS Role

A C<DBMS> object represents a single active Muldis DB virtual machine /
Muldis D environment, which is the widest scope stateful context in which
any other database activities happen.  Other activities meaning the
compilation and execution of Muldis D code, mounting or unmounting depots,
performing queries, data manipulation, data definition, and transactions.
If a C<DBMS> object is ever garbage collected by Perl while it has any
active transactions, then those will all be rolled back, and then an
exception thrown.

=over

=item C<new_var of Muldis::DB::Interface::Var (Str :$decl_type!)>

This method creates and returns a new C<Var> object that is associated with
the invocant C<DBMS>, and whose declared Muldis D type is named by the
C<$decl_type> argument, and whose default Muldis D value is the default
value of its declared type.

=item C<assoc_vars of Array ()>

This method returns, as elements of a new (unordered) Array, all the
currently existing C<Var> objects that are associated with the invocant
C<DBMS>.

=item C<new_func_binding of Muldis::DB::Interface::FuncBinding ()>

This method creates and returns a new C<FuncBinding> object that is
associated with the invocant C<DBMS>.

=item C<assoc_func_bindings of Array ()>

This method returns, as elements of a new (unordered) Array, all the
currently existing C<FuncBinding> objects that are associated with the
invocant C<DBMS>.

=item C<new_proc_binding of Muldis::DB::Interface::ProcBinding ()>

This method creates and returns a new C<ProcBinding> object that is
associated with the invocant C<DBMS>.

=item C<assoc_proc_bindings of Array ()>

This method returns, as elements of a new (unordered) Array, all the
currently existing C<ProcBinding> objects that are associated with the
invocant C<DBMS>.

=item C<call_func of Muldis::DB::Interface::Var (Str :$func_name!, Hash
:$args!)>

This method invokes the Muldis D function named by its C<$func_name>
argument, giving it arguments from C<$args>, and then returning the result
as a new C<Var> object.  This method is conceptually a wrapper over the
creation of a C<FuncBinding> object, setting up its bindings, and invoking
its C<call> method.

=item C<call_proc (Str :$proc_name!, Hash :$upd_args!, Hash :$ro_args!)>

This method invokes the Muldis D procedure named by its C<$proc_name>
argument, giving it subject-to-update arguments from C<$upd_args> and
read-only arguments from C<$ro_args>; the C<Var> objects in C<$upd_args>
are possibly updated as a side-effect of the procedure's execution.  This
method is conceptually a wrapper over the creation of a C<ProcBinding>
object, setting up its bindings, and invoking its C<call> method.

=item C<trans_nest_level of Int ()>

This method returns the current transaction nesting level of its invocant's
virtual machine.  If no explicit transactions were started, then the
nesting level is zero, in which case the DBMS is conceptually
auto-committing every successful Muldis D statement.  Each call of
C<start_trans> will increase the nesting level by one, and each
C<commit_trans> or C<rollback_trans> will decrease it by one (it can't be
decreased below zero).  Note that all transactions started or ended within
Muldis D code are attached to a particular lexical scope in the Muldis D
code (specifically a "try/catch" context), and so they will never have any
effect on the nest level that Perl sees (assuming that a Muldis D host
language will never be invoked by Muldis D), regardless of whether the
Muldis D code successfully returns or throws an exception.

=item C<start_trans ()>

This method starts a new child-most transaction within the invocant's
virtual machine.

=item C<commit_trans ()>

This method commits the child-most transaction within the invocant's
virtual machine; it dies if there isn't one.

=item C<rollback_trans ()>

This method rolls back the child-most transaction within the invocant's
virtual machine; it dies if there isn't one.

=back

=head2 The Muldis::DB::Interface::Var Role

A C<Var> object is a Muldis D variable that is lexically scoped to the Perl
environment (like an ordinary Perl variable).  It is associated with a
specific C<DBMS> object, the one whose C<new_var> method created it, but it
is considered anonymous and non-invokable within the virtual machine.  The
only way for Muldis D code to work with these variables is if they bound to
Perl invocations of Muldis D routines being C<call(|\w+)> by Perl; a Muldis
D routine parameter one is bound to is the name it is referenced by in the
virtual machine.  C<Var> objects are the normal way to directly share or
move data between the Muldis D and Perl environments.  A C<Var> is strongly
typed, and the declared Muldis D type of the variable (which affects what
values it is allowed to hold) is set when the C<Var> object is created, and
this declared type can't be changed afterwards.

=over

=item C<assoc_dbms of Muldis::DB::Interface::DBMS ()>

This method returns the C<DBMS> object that the invocant C<Var> is
associated with.

=item C<decl_type of Str ()>

This method returns the declared Muldis D type of its invocant C<Var>.

=item C<fetch_ast of Array ()>

This method returns the current Muldis D value of its invocant C<Var> as a
Perl Hosted Abstract Muldis D data structure (whose root node is a Perl
Array).

=item C<store_ast (Array :$ast!)>

This method assigns a new Muldis D value to its invocant C<Var>, which is
supplied in the C<$ast> argument; the argument is expected to be a valid
Perl Hosted Abstract Muldis D data structure (whose root node is a Perl
Array).

=back

=head2 The Muldis::DB::Interface::FuncBinding Role

A C<FuncBinding> represents a single Muldis D function that may be directly
invoked by Perl code.  It is associated with a specific C<DBMS> object, the
one whose C<new_func_binding> method created it, and the function it
represents lives in and has a global-public scoped name in the
corresponding virtual machine.  This is specifically a lazy binding, so no
validity checking of the object happens except while the FuncBinding's
C<call> method is being executed, and a then-valid object can then become
invalid afterwards.  A C<FuncBinding> is conceptually used behind the
scenes to implement a C<DBMS> object's C<call_func> method, but you can use
it directly instead, for possibly better performance.

=over

=item C<assoc_dbms of Muldis::DB::Interface::DBMS ()>

This method returns the C<DBMS> object that the invocant C<FuncBinding> is
associated with.

=item C<bind_func (Str :$func_name!)>

This method causes the invocant C<FuncBinding> to be associated with the
Muldis D function named by the C<$func_name> argument.

=item C<bound_func of Str ()>

This method returns the name of the Muldis D function that the invocant
C<FuncBinding> is currently associated with, or undef if that wasn't set.

=item C<bind_result (Muldis::DB::Interface::Var :$var!)>

This method binds the C<Var> object in C<$var> to the result of the Muldis
D function associated with the invocant C<FuncBinding>; when the function
is executed via the FuncBinding, its result will end up in C<$var>.

=item C<bound_result of Muldis::DB::Interface::Var ()>

This method returns the C<Var> object currently bound to the function
result.

=item C<bind_params (Hash :$args!)>

This method binds the C<Var> objects that are the Hash values in C<$args>
to the parameters of the Muldis D function such that they correspond by
Hash key names matching parameter names; when the function is executed via
the FuncBinding, its arguments are pulled from the C<$args>.  Note that the
same C<Var> object may be bound to multiple parameters and/or the result at
once.  This method alternately allows a Perl Array which is Perl Hosted
Muldis D to be supplied instead of any given C<Var> object, in which case a
new C<Var> object will be non-lazily created with that value, and be used
there.

=item C<bound_params of Hash ()>

This method returns, as values of a new Hash, the C<Var> objects currently
bound to the function's parameters, with the corresponding Hash keys being
the names of the parameters they are bound to.

=item C<call ()>

This method performs any lazy validation on the invocant C<FuncBinding>,
and with no failure, it then invokes the Muldis D function.  It is at this
time that the current values of any bound C<Var> objects are taken.

=back

=head2 The Muldis::DB::Interface::ProcBinding Role

A C<ProcBinding> represents a single Muldis D procedure that may be
directly invoked by Perl code.  It is associated with a specific C<DBMS>
object, the one whose C<new_proc_binding> method created it, and the
procedure it represents lives in and has a global-public scoped name in the
corresponding virtual machine.  This is specifically a lazy binding, so no
validity checking of the object happens except while the ProcBinding's
C<call> method is being executed, and a then-valid object can then become
invalid afterwards.  A C<ProcBinding> is conceptually used behind the
scenes to implement a C<DBMS> object's C<call_proc> method, but you can use
it directly instead, for possibly better performance.

=over

=item C<assoc_dbms of Muldis::DB::Interface::DBMS ()>

This method returns the C<DBMS> object that the invocant C<ProcBinding> is
associated with.

=item C<bind_proc (Str :$proc_name!)>

This method causes the invocant C<ProcBinding> to be associated with the
Muldis D procedure named by the C<$proc_name> argument.

=item C<bound_proc of Str ()>

This method returns the name of the Muldis D procedure that the invocant
C<ProcBinding> is currently associated with, or undef if that wasn't set.

=item C<bind_upd_params (Hash :$args!)>

This method binds the C<Var> objects that are the Hash values in C<$args>
to the subject-to-update parameters of the Muldis D procedure such that
they correspond by Hash key names matching parameter names; when the
procedure is executed via the ProcBinding, its subject-to-update arguments
(if they would be used) are pulled from the C<$args>, and resulting values
are written to them (if applicable).

=item C<bound_upd_params of Hash ()>

This method returns, as values of a new Hash, the C<Var> objects currently
bound to the procedure's subject-to-update parameters, with the
corresponding Hash keys being the names of the parameters they are bound
to.

=item C<bind_ro_params (Hash :$args!)>

This method binds the C<Var> objects that are the Hash values in C<$args>
to the read-only parameters of the Muldis D procedure such that they
correspond by Hash key names matching parameter names; when the procedure
is executed via the ProcBinding, its read-only arguments are pulled from
the C<$args>.  Note that the same C<Var> object may be bound to multiple
parameters and/or the result at once.  This method alternately allows a
Perl Array which is Perl Hosted Muldis D to be supplied instead of any
given C<Var> object, in which case a new C<Var> object will be non-lazily
created with that value, and be used there.

=item C<bound_ro_params of Hash ()>

This method returns, as values of a new Hash, the C<Var> objects currently
bound to the procedure's read-only parameters, with the corresponding Hash
keys being the names of the parameters they are bound to.

=item C<call ()>

This method performs any lazy validation on the invocant C<ProcBinding>,
and with no failure, it then invokes the Muldis D procedure.  It is at this
time that the current values of any bound C<Var> objects are taken.

=back

=head1 DIAGNOSTICS

I<This documentation is pending.>

=head1 CONFIGURATION AND ENVIRONMENT

I<This documentation is pending.>

=head1 DEPENDENCIES

This file requires any version of Perl 6.x.y that is at least 6.0.0.

=head1 INCOMPATIBILITIES

None reported.

=head1 SEE ALSO

Go to L<Muldis::DB> for the majority of distribution-internal references,
and L<Muldis::DB::SeeAlso> for the majority of distribution-external
references.

=head1 BUGS AND LIMITATIONS

The Muldis DB framework for Perl 6 is built with a lot of code that should
be superfluous, since the Muldis DB authors can not yet assume that a
number of desired Perl 6 features are actually available in the language
implementations yet, and so and so Muldis DB includes its own substituted
implementations of those features, which have been made as part of Muldis
DB for Perl 5 anyway due to Perl 5's relative deficiencies.  The
reimplemented features include manual type-checks of routine arguments (as
if the parameters were declared C<Any>), and the use of C<Array> rather
than C<Seq> or C<Set> or C<Bag>, and the use of Arrays of Arrays rather
than C<Mapping> or C<Hash> (because non-Str keys may not be supported yet).
Also, explicit clones are made of any "read only" Array or Hash arguments
or return values, so to safeguard the Muldis DB internals against any
subsequent mutation of them by callers.  Hopefully, Muldis DB for Perl 6
will be able to have its code base slimmed considerably when the Perl 6
implementations themselves are more mature.

I<This documentation is pending.>

=head1 AUTHOR

Darren Duncan (C<perl@DarrenDuncan.net>)

=head1 LICENSE AND COPYRIGHT

This file is part of the Muldis DB framework.

Muldis DB is Copyright © 2002-2007, Darren Duncan.

See the LICENSE AND COPYRIGHT of L<Muldis::DB> for details.

=head1 ACKNOWLEDGEMENTS

The ACKNOWLEDGEMENTS in L<Muldis::DB> apply to this file too.

=cut
