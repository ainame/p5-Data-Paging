package Paging::Renderer::Base;
use common::sense;

use Class::Accessor::Lite (
    new => 1,
    ro  => [qw/collection/],
);

sub render {
    die 'implement me';
}

1;
