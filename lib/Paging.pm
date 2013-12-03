package Paging;
use 5.008005;
use strict;
use warnings;

our $VERSION = "0.01";

use Class::Accessor::Lite (
    new => 0,
    ro  => [qw/collection renderer/],
);
use Carp qw/croak/;
use Paging::Collection;

sub new {
    my $class = shift;
    my $collection = Paging::Collection->new($_[0]);
    my $self = bless { collection => $collection }, $class;
    $self->renderer($self->_load_renderer($_[1]));
    $self;
}

sub _load_renderer {
    my ($self, $name) = @_;
    my $renderer = $name ?
        $name =~ s/-/Paging::Renderer::/
        : 'Paging::Renderer::NeighborLink';
    eval { require $renderer };
    croak "can't load renderer" if $@;
    $renderer->new($self->collection);
}

sub render {
    my $self = shift;
    $self->renderer->render;
}

1;
__END__

=encoding utf-8

=head1 NAME

Paging - It's new $module

=head1 SYNOPSIS

    use Paging;

=head1 DESCRIPTION

Paging is ...

=head1 LICENSE

Copyright (C) ainame.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

ainame E<lt>s.namai.2012@gmail.comE<gt>

=cut
