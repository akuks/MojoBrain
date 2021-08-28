package MojoBrain::Controller::Admin::Dashboard;
use Mojo::Base 'Mojolicious::Controller', -signatures;

sub dashboard($c) {
  my $user = $c->app->get_user_details;
  
  $c->render(template => 'admin/dashboard', user => $user);
}

1;