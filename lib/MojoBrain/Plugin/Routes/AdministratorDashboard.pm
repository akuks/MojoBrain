package MojoBrain::Plugin::Routes::AdministratorDashboard;
use Mojo::Base 'Mojolicious::Plugin', -signatures;

sub register ($self, $app, $config) {
  my $r = $app->routes; 
  
  # Check if user is authenticated
  my $admin = $r->under('/admin/dashboard/')->to('Auth::Login#is_user_authenticated');
  $admin->get('/post')->to('Admin::Post#get_post');

  # Stripe Related Data in Admin Dashboard
  $admin->get('/stripe')->to('Admin::Stripe#stripe');
  $admin->post('/stripe')->to('Admin::Stripe#update_stripe');

  return;
}

1;