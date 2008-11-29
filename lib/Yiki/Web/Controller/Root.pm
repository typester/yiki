package Yiki::Web::Controller::Root;
use strict;
use warnings;
use parent 'Catalyst::Controller';

sub index :Chained('/') :PathPart('') :CaptureArgs(1) {
    my ($self, $c, $title) = @_;

    unless ($title) {
        $c->res->redirect( $c->uri_for('/FrontPage') );
        $c->detach;
    }

    $c->stash->{title} = $title;
    $c->stash->{page}  = $c->model('Wiki')->page($title);
}

sub page :Chained('index') :PathPart('') :Args(0) {
    my ($self, $c) = @_;

    $c->detach('/default') unless $c->stash->{page};

    $c->stash->{content} = $c->model('Wiki')->render(
        $c->stash->{page}
    );
}

sub edit :Chained('index') :Args(0) {
    my ($self, $c) = @_;

    my $page = $c->stash->{page} ||
        $c->model('Wiki')->new_page( $c->stash->{title} );
    if ($c->req->method eq 'POST') {
        $page->content( $c->req->param('text') );
        $c->model('Wiki')->save( $page );

        $c->res->redirect( $c->uri_for('/' . $page->title ) );
    }
}

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

=head2 end

Attempt to render a view, if needed.

=cut 

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

Daisuke Murase

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
