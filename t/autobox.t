use Test::More;

BEGIN {
    plan skip_all => "Test requires autobox" unless eval {require autobox};
}

use boolean;
plan tests => 4;

{
    use autobox;
    ok 1->boolean, "1->boolean is true";
    ok not(0->boolean), "0->boolean is false";
    ok 1.1->is_true, "1.1->is_true";
    ok 0.0->is_false, "0.0->is_false";
}
