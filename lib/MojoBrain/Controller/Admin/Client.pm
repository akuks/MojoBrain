package MojoBrain::Controller::Admin::Client;
use Mojo::Base 'Mojolicious::Controller', -signatures;

sub client ($c) {
  $c->stash( 'module' => 'Clients' );
  $c->render( template => '/admin/client')
}

1;