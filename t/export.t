use Test::More tests => 4 * 5;
use strict;
# use warnings;
use lib 'lib';

package None;
use boolean();

package Default;
use boolean;

package All;
use boolean ':all';

package Test;
use boolean ':test';

package main;

my @functions = qw(true false isTrue isFalse isBoolean);
my @exports = qw(None Default All Test);
my %exported = (
    None    => [0,0,0,0,0],
    Default => [1,1,0,0,0],
    All     => [1,1,1,1,1],
    Test    => [0,0,1,1,1],
);

for my $export (@exports) {
    my $tag = ":" . lc($export);
    for (my $i = 0; $i < @functions; $i++) {
        my $function = $functions[$i];
        my $exported = $exported{$export}->[$i];
        my $defined = defined(&{$export . "::" . $function}) ? 1 : 0;
        my $test = $exported == $defined;
        ok $test,
            $tag .
            ($exported ? " imports " : " does not import ") .
            $function;
    }
}
