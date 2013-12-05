use strict;
use warnings;

use Test::More;
use Paging::Collection;

BEGIN {
    use_ok 'Paging::Renderer::Base';
}

subtest 'new' => sub {
    my $renderer = Paging::Renderer::Base->new;
    isa_ok $renderer, 'Paging::Renderer::Base';
};

subtest 'render' => sub {
    my $renderer = Paging::Renderer::Base->new;
    can_ok $renderer, 'render';
};

done_testing;
