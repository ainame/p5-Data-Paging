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

Paging - pagination helper for view

=head1 SYNOPSIS

use Paging;

my $paging = Paging->create({
    entries      => $entries,
    total_count  => 100,
    per_page     => 30,
    current_page => 1,
});

$paging->has_next;    #=> TRUE
$paging->has_prev;    #=> FALSE
$paging->prev_page;   #=> 0
$paging->next_page;   #=> 2
$paging->begin_count; #=> 30
$paging->end_count;   #=> 30
...

# If you use simple template engine like HTML::Template,
# you should use Paging with renderer.
my $paging = Paging->create({
    entries      => $entries,
    total_count  => 100,
    per_page     => 30,
    current_page => 1,
}, '-NeighborLink');  # NeighborLink is the bundled renderer. You can load renderer like Plack::Middleware.

$paging->render #=> output HASHREF value

=head1 DESCRIPTION

`Paging` is the helper library for implementation of paging.
Especialy, `Paging` class is the factory class of Paging::Collection.

Paging::Collection is the accessor of many pagination parameters like `Data::Page`.
`Data::Page` make us implement paging ui, but that ui only simple paging.

`Paging` always has next or prev page number. This feature difference from Data::Page' one.
And, if you create a Paging::Collection's instance with `window` parameter,
you can use this like `Data::Page::Navigation`.

=head1 LICENSE

Copyright (C) ainame.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

ainame E<lt>s.namai.2012@gmail.comE<gt>

=cut
