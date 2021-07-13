package MojoBrain::Controller::Admin::Dashboard;
use Mojo::Base 'Mojolicious::Controller', -signatures;

sub dashboard($c) {
  print $c->session('user_exists'), "\n";
  $c->render(template => 'admin/dashboard');
}

1;