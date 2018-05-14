#/usr/bin/env perl
use strict;
use warnings;
use 5.010;
use JSON::PP;
use boolean;
use Text::Table;

my @headers = (
    '', 'native true',
    qw/boolean::true JSON::PP::true/, 'native false',
    qw/boolean::false JSON::PP::false/
);
my $tb = Text::Table->new(map { "$_\n&center" } @headers);

my @rows = (
    ['"$b"'],
    ['if ($b)'],
    ['! $b'],
    ['ref(! $b)'],
    ['++$b'],
    ['ref(++$b)'],
    ['--$b'],
    ['ref(--$b)'],
    ['$b + 0'],
    ['ref($b + 0)'],
    ['$b += 2'],
    ['ref($b += 2)'],
    ['$b -= 2'],
    ['ref($b -= 2)'],
    ['if (!!$b == 0)'],
);

for my $item (
    [ 'native true' => !!1 ],
    [ 'boolean true' => true ],
    [ 'JSON::PP true' => JSON::PP::true ],
    [ 'native false' => !!0 ],
    [ 'boolean false' => false ],
    [ 'JSON::PP false' => JSON::PP::false ],
    ) {
    my ($name, $b) = @$item;
    my $str = "$b";
    push @{ $rows[0] }, "$b";

    my $if = '';
    if ($b) {
        $if = "is true";
    }
    else {
        $if = "is false";
    }
    push @{ $rows[1] }, "$if";

    my $not = ! $b;
    push @{ $rows[2] }, "$not";
    push @{ $rows[3] }, ref $not;

    my $plus = $b;
    ++$plus;
    push @{ $rows[4] }, "$plus";
    push @{ $rows[5] }, ref $plus;

    my $minus = $b;
    --$minus;
    push @{ $rows[6] }, "$minus";
    push @{ $rows[7] }, ref $minus;

    my $plus0 = $b + 0;
    push @{ $rows[8] }, "$plus0";
    push @{ $rows[9] }, ref $plus0;

    my $plusequal = $b;
    $plusequal += 2;
    push @{ $rows[10] }, "$plusequal";
    push @{ $rows[11] }, ref $plusequal;

    my $minusequal = $b;
    $minusequal -= 2;
    push @{ $rows[12] }, "$minusequal";
    push @{ $rows[13] }, ref $minusequal;

    my $if2 = '';
    if (!!$b == 0) {
        $if2 = "is true";
    }
    else {
        $if2 = "is false";
    }
    push @{ $rows[14] }, "$if";

}

for my $row (@rows) {
    map {
        $_ //= 'undef';
        $_ = "''" unless length $_;
    } @$row;
}
$tb->load(@rows);
print $tb;
