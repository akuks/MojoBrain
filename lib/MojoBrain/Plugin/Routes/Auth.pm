package MojoBrain::Plugin::Routes::Auth;
use Mojo::Base 'Mojolicious::Plugin', -signatures;

sub register ($self, $app, $config) {
  my $r = $app->routes; 
  
  my $auth = $r->under('/signup');
  $auth->get('/')->to('Auth::Register#signup');
  $auth->post('/')->to('Auth::Register#signup_post');

  return;
}

1;