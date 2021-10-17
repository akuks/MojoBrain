package MojoBrain::Controller::Auth::Register;
use Mojo::Base 'Mojolicious::Controller', -signatures;
use JSON;
use Email::Valid;
use Trim;

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

  # Check if user exists
  if ( $c->app->db->resultset('User')->is_user_exists( $c->param('email') ) ) {
    $c->flash( email_exists  => 'User already exists.' );
  }

  $v->required('name')->like(q/[a-zA-Z]/);
  $v->required('email')->like( Email::Valid->address( $c->param('email') ) );
  $v->required('password')->like(qr/^[a-zA-Z0-9]+$/);
  $v->required('confirm_password')->equal_to('password') if $v->optional('password')->is_valid;

  my %options;
  
  # Parameter validation has errors
  if ( $v->has_error ) {
    $c->flash( name_error      => $v->error('name') );
    $c->flash( email_error     => $v->error('email') );
    $c->flash( pass_error      => $v->error('password') );
    $c->flash( conf_pass_error => $v->error('confirm_password') );
    return $c->redirect_to( '/signup' );
  }
  
  my $slug = $c->param('name');
  $slug =~ s/ +//g;

  %options = (
    name       => trim $c->param('name'),
    email      => trim $c->param('email'),
    password   => trim $c->app->bcrypt( $c->param('password') ),
    created_by => $c->param('created_by') ? trim $c->param('created_by') : 'Self',
    slug       => $slug
  );

  my $user = $c->app->db->resultset('User')->create_user(\%options); 

  if ( $user ) {
    $c->flash( success => 'User Created Succesfully.');
    return $c->redirect_to( '/admin/login' );
  }
  else {
    $c->flash( generic_error => 'User cannot be created. Please contact support for more details.' );
    return $c->redirect_to( '/signup' );
  }
}

1;
