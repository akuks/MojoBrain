package MojoBrain::Controller::Auth::Login;
use Mojo::Base 'Mojolicious::Controller', -signatures;
use JSON;

# This action will render a template
sub login ($c) {
  $c->openapi->valid_input or return;

  my $username = $c->param('username');
  my $password = $c->param('password');

  if ( !$username or !$password) {
    return $c->render( json => { message => 'Username or password cannot be left blank', status => 404 });
  }

  return $c->render( json =>  { message => 'It works', status => 200 } );
}

1;
