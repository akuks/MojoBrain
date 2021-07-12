package MojoBrain::Controller::Admin::Auth;
use Mojo::Base 'Mojolicious::Controller', -signatures;

sub signin($c) {
  
  $c->render(template => 'layouts/admin/signin')
}

sub signin_post ($c) {
  my $username = $c->param('username');
  my $password = $c->param('password');

  unless ($c->is_user_exists($username, $password)) {
    $c->flash( credential_error => $c->app->msg->get_invalid_credentials_message );
    return $c->redirect_to('/admin/login');
  }

}

sub register($c) {
  $c->render(template => 'layouts/admin/register')
}

sub is_user_exists($c, $username, $password) {
  my $user = $c->app->db->resultset('User')->search({
    email => $username
  });
  return 0 if !$user->count;

  $user = $user->first;
  
  return $c->bcrypt_validate($password || '', $user->password);
}



1;