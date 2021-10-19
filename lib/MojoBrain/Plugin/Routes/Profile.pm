package MojoBrain::Plugin::Routes::Profile;
use Mojo::Base 'Mojolicious::Plugin', -signatures;

sub register ($self, $app, $config) {
  my $r = $app->routes; 
  
  my $auth = $r->under('/profile')->to('Auth::Login#is_user_authenticated');
  $auth->get('/')->to('Auth::Profile#profile');
  $auth->post('/')->to('Auth::Profile#profile_post');

  return;
}

1;