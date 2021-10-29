package MojoBrain::Plugin::Routes::Client;
use Mojo::Base 'Mojolicious::Plugin', -signatures;

sub register ($self, $app, $config) {
  my $r = $app->routes; 
  
  my $auth = $r->under('/clients')->to('Auth::Login#is_user_authenticated');
  $auth->get('/')->to('Admin::Client#client');
  $auth->post('/')->to('Admin::Client#client_post');

  return;
}

1;