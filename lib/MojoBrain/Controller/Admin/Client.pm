package MojoBrain::Controller::Admin::Client;
use Mojo::Base 'Mojolicious::Controller', -signatures;

sub client ($c) {
  my $details = $c->app->db->resultset('Client')->get_client_details( $c->session('user_id') );

  $c->stash( 'module' => 'Clients' );
  $c->stash( 'details' => $details );
  
  $c->render( template => '/admin/client')
}

1;