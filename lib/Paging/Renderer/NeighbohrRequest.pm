package Paging::Renderer::NeighborRequest;
use common::sense;

use parent 'Paging::Renderer::Base';

sub render {
    my $self = shift;
    my $collection = $self->collection;

    return +{
        entries     => $collection->sliced_entries,
        total_count => $collection->total_count,
        paging      => {
            next     => {
                base_entry_id => $collection->begin_entry->id,
            },
            previous => {
                base_entry_id => $collection->last_entry->id,
            }
        },
    };
}

1;
