package Paging::Renderer::NeighborLink;
use common::sense;

use parent 'Paging::Renderer::Base';

sub render {
    my $self = shift;
    my $collection = $self->collection;

    return {
        entries      => $collection->entries,
        has_perv     => $collection->has_prev,
        prev_page    => $collection->next_page,
        has_next     => $collection->has_next,
        next_page    => $collection->next_page,
        current_page => $collection->current_page,
    };
}

1;
