package Paging;
use common::sense;

our $VERSION = "0.01";

use Class::Accessor::Lite (
    new => 0,
    rw  => [qw/collection/],
);
use Carp qw/croak/;
use Paging::Collection;

sub create {
    my ($class, $collection_param, $renderer_name) = @_;
    my $collection = Paging::Collection->new(%$collection_param);
    $collection->renderer($class->_create_renderer($renderer_name)) if $renderer_name;
    $collection;
}

sub _create_renderer {
    my ($class, $renderer_name) = @_;
    my $package = $class->_load_renderer($renderer_name);
    $package->new;
}

sub _load_renderer {
    my ($class, $name) = @_;
    croak "done't set renderer" unless $name;

    my $package = $name =~ s/-/Paging::Renderer::/r;
    my $path = $package =~ s!::!/!rg;
    eval { require "$path.pm" };  ## no critic
    croak "can't load renderer: $path" if $@;

    $package;
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

ainame E<lt>s.namai.09@gmail.comE<gt>

=cut
