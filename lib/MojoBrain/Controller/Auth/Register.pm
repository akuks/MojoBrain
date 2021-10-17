package MojoBrain::Controller::Auth::Register;
use Mojo::Base 'Mojolicious::Controller', -signatures;
use JSON;
use Email::Valid;

# This action will render a template
# Not used. Need to move in a separate folder
sub register ($c) {
  $c->openapi->valid_input or return;

  my $username = $c->param('username');
  my $password = $c->param('password');

  if ( !$username or !$password) {
    return $c->render( json => { message => 'Username or password cannot be left blank', status => 404 });
  }

  

  return $c->render( json =>  { message => 'User registered succesfully.', status => 200 } );
}

# This action will render a template
sub signup ($c) {
  $c->render( template => 'auth/signup' )
}


sub signup_post ($c) {

  my $v = $c->validation;
  $v = $v->csrf_protect;

  return $c->render(text => 'Bad CSRF token!', status => 403) if $v->csrf_protect->has_error('csrf_token');

  $v->required('name')->like(q/[a-zA-Z]/);
  $v->required('email')->like( Email::Valid->address( $c->param('email') ) );
  $v->required('password')->like(qr/^[a-z0-9]+$/);
  $v->required('confirm_password')->equal_to('password') if $v->optional('password')->size(7, 500)->is_valid;

  my %options;
  
  # Validation has any errors
  if ( $v->has_error ) {
    $c->flash( name_error => $v->error('name') );
    $c->flash( email_error => $v->error('email') );
    $c->flash( pass_error => $v->error('password') );
    $c->flash( conf_pass_error => $v->error('confirm_password') );
    return $c->redirect_to( '/signup' );
  }
  
  %options = (
    name  => $c->param('name'),
    email => $c->param('email')
  );

  return $c->redirect_to( '/signup' );

  $c->render( template => 'auth/signup' )
}

1;
