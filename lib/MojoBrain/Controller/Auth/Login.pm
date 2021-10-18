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

  my $access_key = "some secret key";

  return $c->render( json =>  { message => 'User login succesfully.', status => 200, access_key => $access_key } );
}

sub is_user_authenticated($c) {
  if ( $c->session('user_exists') ) {
    my $user = $c->app->get_user_details(  $c->session('user_id') );
  
    $c->stash( user => $user );
    return 1;
  }
  $c->redirect_to('/admin/login');
  return undef;
}

1;
