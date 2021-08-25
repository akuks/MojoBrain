package MojoBrain::Plugin::Routes::AdministratorDashboard;
use Mojo::Base 'Mojolicious::Plugin', -signatures;

sub register ($self, $app, $config) {
  my $r = $app->routes; 
  
  my $admin = $r->under('/admin/dashboard/');

  return;
}

1;