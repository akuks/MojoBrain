package MojoBrain::Plugin::Routes::Project;
use Mojo::Base 'Mojolicious::Plugin', -signatures;

sub register ($self, $app, $config) {
  my $r = $app->routes; 
  
  my $proj = $r->under('/projects')->to('Auth::Login#is_user_authenticated');
  $proj->get('/')->to('Admin::Project#project');
  $proj->post('/')->to('Admin::Project#project_post');
  # Individual Project details
  $proj->get('/:project_id')->to('Admin::Project#project_details');

  return;
}

1;