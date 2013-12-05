use common::sense;
use Test::More;

BEGIN {
    use_ok 'Paging';
}

subtest 'instantiate with collection and renderer name' => sub {
    subtest 'should ommit renderer name of prefix' => sub {
        my $paging = Paging->create({
            entries      => [qw/a b c d e f/],
            total_count  => 10,
            per_page     => 5,
            current_page => 1,
        }, '-NeighborLink');
        isa_ok $paging, "Paging::Collection";
        isa_ok $paging->renderer, "Paging::Renderer::NeighborLink";
    };

    subtest 'should accept renderer name by full name' => sub {
        my $paging = Paging->create({
            entries      => [qw/a b c d e f/],
            total_count  => 10,
            per_page     => 5,
            current_page => 1,
        }, 'Paging::Renderer::NeighborLink');
        isa_ok $paging, "Paging::Collection";
        isa_ok $paging->renderer, "Paging::Renderer::NeighborLink";
    };

    subtest 'should accept renderer name by full name' => sub {
        my $paging = Paging->create({
            entries      => [qw/a b c d e f/],
            total_count  => 10,
            per_page     => 5,
            current_page => 1,
        }, 'Paging::Renderer::NeighborLink');

        use Data::Dumper;
        warn Dumper $paging->render;

        is_deeply $paging->render, {
        };
    };
};

done_testing;
