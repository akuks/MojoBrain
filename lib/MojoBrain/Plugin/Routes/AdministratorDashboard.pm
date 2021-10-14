package MojoBrain::Plugin::Routes::AdministratorDashboard;
use Mojo::Base 'Mojolicious::Plugin', -signatures;

sub register ($self, $app, $config) {
  my $r = $app->routes; 
  
  my $admin = $r->under('/admin/dashboard/');
  $admin->get('/post')->to('Admin::Post#get_post');

  return;
}

1;