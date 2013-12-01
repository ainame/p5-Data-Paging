use common::sense;
use t::helper;

use Test::More;
use Paging::Collection;

BEGIN {
    use_ok 'Paging::Renderer::Base';
}

subtest 'collection' => sub {
    my $renderer = Paging::Renderer::Base->new(
        collection => Paging::Collection->new(
            entries => []
        )
    );
    ok $renderer->collection;
};

done_testing;
