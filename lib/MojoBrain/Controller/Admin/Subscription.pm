package MojoBrain::Controller::Admin::Subscription;
use Mojo::Base 'Mojolicious::Controller', -signatures;

sub index ( $c ) {

  $c->render( template => 'admin/subscription/subscription')
}

1;