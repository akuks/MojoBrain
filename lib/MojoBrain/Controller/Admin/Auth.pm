package MojoBrain::Controller::Admin::Auth;
use Mojo::Base 'Mojolicious::Controller', -signatures;

sub signin($c) {
  
  $c->render(template => 'layouts/admin/layout')
}


1;