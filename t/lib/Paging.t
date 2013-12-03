use common::sense;
use Test::More;

BEGIN {
    use_ok 'Paging';
}

subtest 'instantiate with collection' => sub {
    my $paing = Paging->new({
        entries      => [qw/a b c d e f/],
        total_count   => $total_count,
        per_page     => 5,
        current_page => 1,
    }, '-NeighborLink');
};

done_testing;
