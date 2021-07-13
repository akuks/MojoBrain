package MojoBrain::Controller::Admin::Auth;
use Mojo::Base 'Mojolicious::Controller', -signatures;

sub signin($c) {
  if ($c->session('user_exists')) {
    return $c->redirect_to('/admin/dashboard');
  }
  $c->render(template => 'layouts/admin/signin')
}

sub signin_post ($c) {
  my $username = $c->param('username');
  my $password = $c->param('password');

  unless ($c->is_user_exists($username, $password)) {
    $c->flash( credential_error => $c->app->msg->get_invalid_credentials_message );
    return $c->redirect_to('/admin/login');
  }

  $c->app->plugin('authentication' => {
    autoload_user   => 1,
    load_user       => sub {
      my ($c, $user_key, $user_pass) = @_;
      my $user_exists = $c->db->resultset('User')->search({email => $username});
      my $token = $c->jwt->claims({ username => $username.'-'.$password })->encode;
      return $user_exists->first;
    },
    validate_user => sub {
      my ($c, $username, $password) = @_; 
      my $user_details = $c->db->resultset('User')->search(
          {email => $username}
      );
      
      $c->session(user_exists => $c->is_user_exists($username, $password));
      $c->session(user_id => $user_details->first->id);

      return $c->session('user_exists');
    }
  });
  my $auth_key = $c->authenticate($username, $password );

  if ( $auth_key ) {
    my $redirect = _get_redirect_url($c->req->headers->referrer);
    my $r = ($redirect and $redirect !~ /login/) ? $redirect : '/admin/dashboard';
    return $c->redirect_to($r);
  }
  else {
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

sub _get_redirect_url ($url) {
  my @url = split('redirect=', $url);
  chomp(@url);
  return $url[1];
}


1;