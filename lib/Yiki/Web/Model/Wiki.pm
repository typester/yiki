package Yiki::Web::Model::Wiki;
use strict;
use warnings;
use base 'Catalyst::Model::Adaptor';

__PACKAGE__->config( 
    class       => 'Yiki',
    constructor => 'new',
);

sub new {
    my $self = shift->NEXT::new(@_);
    my $c = shift;

    $self->{args}{data_dir} = $c->config->{data_dir};

    $self;
}

1;
