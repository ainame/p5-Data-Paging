package Paging::Collection;
use common::sense;

use Class::Accessor::Lite (
    new => 0,
    ro  => [qw/
        entries
        total_count
        per_page
        current_page
        base_url
        direction
        window
        outer_window
        left_window
        right_window
    /]
);

use Carp qw/croak/;

sub new {
    my ($class, %args) = @_;
    bless \%args, $class;
}

sub sliced_entries {
    my $self = shift;
    scalar(@{$self->entries}) > $self->per_page ?
        [@{$self->entries}[0..($self->per_page-1)]] : $self->entries;
}

sub current_visit_count {
    my $self = shift;
    scalar(@{$self->sliced_entries});
}

sub already_visited_count {
    my $self = shift;
    $self->per_page * ($self->current_page - 1)
}

sub visited_count {
    my $self = shift;
    $self->already_visited_count + $self->current_visit_count;
}

sub begin_count {
    my $self = shift;
    $self->already_visited_count + 1;
}

sub begin_position {
    my $self = shift;
    1;
}

sub end_count {
    my $self = shift;
    $self->visited_count;
}

sub end_position {
    my $self = shift;
    scalar(@{$self->sliced_entries});
}

sub begin_entry {
    my $self = shift;
    $self->sliced_entries->[$self->begin_position];
}

sub end_entry {
    my $self = shift;
    $self->sliced_entries->[$self->end_position];
}

sub first_page {
    my $self = shift;
    1;
}

sub last_page {
    my $self = shift;
    croak "can't calc last_page without total_count" unless defined $self->total_count;
    int($self->total_count / $self->per_page);
}

sub has_prev {
    my $self = shift;
    $self->current_page > $self->first_page;
}

sub prev_page {
    my $self = shift;
    $self->current_page - 1;
}

sub has_next {
    my $self = shift;
    $self->total_count ?
        $self->current_page < $self->last_page
        : scalar(@{$self->entries}) > $self->per_page;
}

sub next_page {
    my $self = shift;
    $self->current_page + 1;
}

1;
