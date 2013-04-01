use Test::More tests => 2;
use boolean -truth;
my $HAVE_JSON = eval { require JSON };
SKIP: {
    skip "JSON is missing", 2 unless $HAVE_JSON;
    eval{
        my $json = JSON->new->convert_blessed();
        is($json->encode({false => (0 == 1)}), '{"false":false}');
        is($json->encode({true  => (1 == 1)}), '{"true":true}');
    }
};
