package MojoBrain::Plugin::Routes::Invoice;
use Mojo::Base 'Mojolicious::Plugin', -signatures;

sub register ($self, $app, $config) {
  my $r = $app->routes; 
  
  my $invoice = $r->under('/invoices')->to('Auth::Login#is_user_authenticated');
  $invoice->get('/')->to('Admin::Invoice#index');
  # $proj->post('/')->to('Admin::Invoice#project_post');
  # # Individual Project details
  # $proj->get('/:project_key')->to('Admin::Project#project_details');
  # $proj->post('/:project_key/task')->to('Admin::Project#add_task');
  # $proj->post('/:project_key/task/update')->to('Admin::Project#update_task');
  return;
}

1;