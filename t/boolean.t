use Test::More tests => 20;
use strict;
use lib 'lib';

use boolean ':all';

ok true, 'true is defined and works';
ok !false, 'false is defined and works';

ok isTrue(true), "isTrue works with true";
ok isFalse(false), "isFalse works false";

ok not(isTrue(false)), "isTrue not true with false";
ok not(isFalse(true)), "isFalse not true with true";

ok isBoolean(true), 'true isBoolean';
ok isBoolean(false), 'false isBoolean';

ok not(isBoolean(undef)), 'undef is not Boolean';
ok not(isBoolean("")), '"" is not Boolean';
ok not(isBoolean(0)), '0 is not Boolean';
ok not(isBoolean(1)), '1 is not Boolean';

ok isBoolean(isFalse(isFalse(undef))), 'boolean return values are boolean';

# Test true in various contexts
my $t = true;

is ref($t), 'boolean', "ref(true) eq 'boolean'";

is "$t", "1", "true stringifies to '1'";

my $t1 = $t ? "true" : "false";
is $t1, "true", "Ternary works with true";

my $t2;
if ($t) {
    $t2 = "true";
}
else {
    $t2 = "false";
}
is $t2, "true", "'if' works with true";


# Test false in various contexts
my $f = false;

is "$f", "0", "false stringifies to '0'";

my $f1 = $f ? "true" : "false";
is $f1, "false", "Ternary works with false";

my $f2;
if ($f) {
    $f2 = "true";
}
else {
    $f2 = "false";
}
is $f2, "false", "'if' works with false";


# my $c = true;
# $$c = 0;
# ok $c ? 1 : 0, "true is imutable";

