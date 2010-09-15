package boolean;
use 5.005003;
use strict;
# use warnings;
$boolean::VERSION = '0.21';

my ($true, $false);

use overload
    '""' => sub { ${$_[0]} },
    '!' => sub { ${$_[0]} ? $false : $true },
#     '${}' => sub {
#         require Carp;
#         Carp::croak("Attempt to dereference boolean value is illegal");
#     },
    fallback => 1;

use base 'Exporter';
@boolean::EXPORT = qw(true false boolean);
@boolean::EXPORT_OK = qw(isTrue isFalse isBoolean);
%boolean::EXPORT_TAGS = (
    all    => [@boolean::EXPORT, @boolean::EXPORT_OK],
    test   => [qw(isTrue isFalse isBoolean)],
);

my ($true_val, $false_val, $bool_vals);

BEGIN {
    $true  = do {bless \(my $t = 1), 'boolean'};
    $false = do {bless \(my $f = 0), 'boolean'};
    $true_val  = overload::StrVal($true);
    $false_val = overload::StrVal($false);
    $bool_vals = {$true_val => 1, $false_val => 1};
}

# use XXX;
sub true()  { $true }
sub false() { $false }
sub boolean($) {
    return $false if scalar(@_) == 0;
    return $true if scalar(@_) > 1;
    return not(defined $_[0]) ? false :
    "$_[0]" ? $true : $false;
}
sub isBoolean($) {
    not(defined $_[0]) ? false :
    (exists $bool_vals->{overload::StrVal($_[0])}) ? true : false;
}
sub isTrue($)  {
    not(defined $_[0]) ? false :
    (overload::StrVal($_[0]) eq $true_val)  ? true : false;
}
sub isFalse($) {
    not(defined $_[0]) ? false :
    (overload::StrVal($_[0]) eq $false_val) ? true : false;
}

1;

=encoding utf8

=head1 NAME

boolean - Boolean support for Perl

=head1 SYNOPSIS

    use boolean;

    do &always if true;
    do &never if false;

and:

    use boolean ':all';

    $guess = int(rand(2)) % 2 ? true : false;

    do &something if isTrue($guess);
    do &something_else if isFalse($guess);

=head1 DESCRIPTION

Most programming languages have a native C<Boolean> data type.
Perl does not.

Perl has a simple and well known Truth System. The following scalar
values are false:

    $false1 = undef;
    $false2 = 0;
    $false3 = 0.0;
    $false4 = '';
    $false5 = '0';

Every other scalar value is true.

This module provides basic Boolean support, by defining two special
objects: C<true> and C<false>.

=head1 IMPLEMENTATION NOTE

Version 0.20 is a complete rewrite from version 0.12. The old version
used XS and had some fundamental flaws. The new version is pure Perl and
is more correct. The new version depends on overload.pm to make the
true and false objects return 1 and 0 respectively.

The "null" support found in 0.12 was also removed as superfluous.

=head1 RATIONALE

When sharing data between programming languages, it is important to
support the same group of basic types. In Perlish programming languages,
these types include: Hash, Array, String, Number, Null and Boolean. Perl
lacks native Boolean support.

Data interchange modules like YAML and JSON can now C<use boolean> to
encode/decode/roundtrip Boolean values.

=head1 FUNCTIONS

This module defines the following functions:

=over

=item true

This function returns a scalar value which should evaluate to true. The
value is a singleton object, meaning there is only one "true" value in a
Perl process at any time. You can check to see whether the value is the
"true" object with the isTrue function described below.

=item false

This function returns a scalar value which should evaluate to false. The
value is a singleton object, meaning there is only one "false" value in a
Perl process at any time. You can check to see whether the value is the
"false" object with the isFalse function described below.

=item isTrue($scalar)

Returns C<boolean::true> if the scalar passed to it is the
C<boolean::true> object. Returns C<boolean::false> otherwise.

=item isFalse($scalar)

Returns C<boolean::true> if the scalar passed to it is the
C<boolean::false> object. Returns C<boolean::false> otherwise.

=item isBoolean($scalar)

Returns C<boolean::true> if the scalar passed to it is the
C<boolean::true> or C<boolean::false> object. Returns C<boolean::false>
otherwise.

=back

=head1 EXPORTABLES

By default this module exports the C<true> and C<false> functions.

The module also defines these export tags:

=over

=item :all

Exports C<true>, C<false>, C<isTrue>, C<isFalse>, C<isBoolean>

=item :test

Exports C<isTrue>, C<isFalse>, C<isBoolean>

=back

=head1 AUTHOR

Ingy döt Net <ingy@cpan.org>

=head1 COPYRIGHT

Copyright (c) 2007, 2008. Ingy döt Net.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See http://www.perl.com/perl/misc/Artistic.html

=cut
