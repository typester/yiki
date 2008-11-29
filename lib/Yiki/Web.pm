package Yiki::Web;

use strict;
use warnings;

use Catalyst::Runtime '5.70';
use parent qw/Catalyst/;

use Catalyst qw/ConfigLoader/;

our $VERSION = '0.01';

__PACKAGE__->config(
    'Plugin::ConfigLoader' => { file => __PACKAGE__->path_to('config')->stringify },
    'Controller::Root' => { namespace => '' },
);

# Start the application
__PACKAGE__->setup;


=head1 NAME

Yiki::Web - Catalyst based application

=head1 SYNOPSIS

    script/yiki_web_server.pl

=head1 DESCRIPTION

[enter your description here]

=head1 SEE ALSO

L<Yiki::Web::Controller::Root>, L<Catalyst>

=head1 AUTHOR

Daisuke Murase

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
