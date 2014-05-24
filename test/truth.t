use Test::More tests => 8;

use boolean -truth;

is ref(1 == 0), 'boolean',
    'Turn false == value into boolean';

is ref(1 == 1), 'boolean',
    'Turn true == value into boolean';

is ref("foo" eq "bar"), 'boolean',
    'Turn false "eq" value into boolean';

is ref("foo" ne "bar"), 'boolean',
    'Turn true "ne" value into boolean';

is ref("foo" =~ /o/), 'boolean',
    'Turn true regex into boolean';

is ref("foo" =~ /bar/), 'boolean',
    'Turn false regex into boolean';

is 1 == 0, '0',
    'False is 0';

is 1 == 1, '1',
    'True is 1';
