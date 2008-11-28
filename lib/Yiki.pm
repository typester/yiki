package Yiki;
use Moose;
use MooseX::Types::Path::Class;

use Text::Markdown;

use Yiki::Page;

our $VERSION = '0.01';

has data_dir => (
    is       => 'rw',
    isa      => 'Path::Class::Dir',
    required => 1,
    coerce   => 1,
);

has data_ext => (
    is      => 'rw',
    isa     => 'Str',
    default => sub { '.txt' },
);

has markdown => (
    is      => 'rw',
    isa     => 'Text::Markdown',
    lazy    => 1,
    default => sub { Text::Markdown->new }
);

sub pages {
    my $self = shift;

    my @pages;
    for my $f ($self->data_dir->children) {
        next unless -f $f && -r _;
        next unless $f =~ /$self->{data_ext}$/;

        (my $title = $f->basename) =~ s/$self->{data_ext}$//;
        push @pages, $title;
    }

    \@pages;
}

sub page {
    my ($self, $title) = @_;

    my $f = $self->data_dir->file( $title . $self->{data_ext} );
    return unless -f $f && -r _;

    Yiki::Page->new(
        title   => $title,
        content => scalar $f->slurp,
    );
}

sub new_page {
    my ($self, $title) = @_;

    Yiki::Page->new( title => $title );
}

sub save {
    my ($self, $page) = @_;

    my $f = $self->data_dir->file( $page->title . $self->data_ext );

    my $fh = $f->openw or confess $!;
    print $fh $page->content;
    $fh->close;
}

sub render {
    my ($self, $page) = @_;
    $self->markdown->markdown($page->content);
}

=head1 NAME

Yiki - Module abstract (<= 44 characters) goes here

=head1 SYNOPSIS

  use Yiki;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for this module was created by ExtUtils::ModuleMaker.
It looks like the author of the extension was negligent enough
to leave the stub unedited.

Blah blah blah.

=head1 AUTHOR

Daisuke Murase <typester@cpan.org>

=head1 COPYRIGHT

This program is free software; you can redistribute
it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the
LICENSE file included with this module.

=cut

1;
