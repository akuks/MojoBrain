package MojoBrain::Controller::Admin::Dashboard;
use Mojo::Base 'Mojolicious::Controller', -signatures;

sub dashboard($c) {
  my $user = $c->app->db->resultset('User')->get_user_details(  $c->session('user_id') );
  
  $c->stash( user => $user );
  $c->stash( module => 'Dashboard' );
  $c->render( template => 'admin/dashboard' );
}

1;