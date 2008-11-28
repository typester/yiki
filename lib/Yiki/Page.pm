package Yiki::Page;
use Moose;

has title => (
    is       => 'rw',
    isa      => 'Str',
    required => 1,
);

has content => (
    is      => 'rw',
    isa     => 'Str',
    default => sub { '' },
);

1;

