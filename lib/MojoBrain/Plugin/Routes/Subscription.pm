package MojoBrain::Plugin::Routes::Subscription;
use Mojo::Base 'Mojolicious::Plugin', -signatures;

sub register ($self, $app, $config) {
  my $r = $app->routes; 
  
  my $subscription = $r->under('/subscriptions')->to('Auth::Login#is_user_authenticated');
  $subscription->get('/')->to('Admin::Subscription#index');

  return;
}

1;