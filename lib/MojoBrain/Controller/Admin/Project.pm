package MojoBrain::Controller::Admin::Project;
use Mojo::Base 'Mojolicious::Controller', -signatures;

sub project ($c) {
  my $details  = $c->app->db->resultset('Client')->get_client_details( $c->session('user_id') );
  my $currency = $c->app->db->resultset('Currency')->get_all_currency();
  my $projects = $c->app->db->resultset('Project')->get_project_details_by_user( $c->session('user_id') );

  $c->stash( 'module'   => 'Projects' );
  $c->stash( 'details'  => $details );
  $c->stash( 'currency' => $currency );
  $c->stash( 'projects' => $projects );

  $c->render( template => '/admin/project')
}

sub project_post ($c) {
  my $v = $c->validation;

  my %options;

  # Form Validation Plugin
  foreach(qw/client_name project_name contract_type rate currency/) {
    $c->form_validation->{ $_ }->( $v ) ;
    my $elem = ( $_ eq 'client_name' or $_ eq 'currency' )
      ? ( $_ eq 'client_name' ? 'client_id' : 'currency_id' )
      : $_ ;
    $options { $elem } = $c->param( $_ );
  }

  $options { user_id } = $c->session( 'user_id' );

  return $c->render ( json => { error => 'Invalid form parameters are passed.' } ) if ( $v->has_error );

  my $project = $c->app->db->resultset('Project')->create_update_project( \%options );

  my $output;
  if ( $project ) {
    $output->{message} = 'Client added/updated succesfully.';
    $output->{status} = 200;
  }
  else {
    $output->{error} = 'Failed to add/update client.';
  }

  $c->render( json => $output );
}

sub project_details ( $c ) {
  my $user_id = $c->session( 'user_id' );
  my $project_key = $c->param( 'project_id' );

  my $project = $c->app->db->resultset('Project')->get_individual_project_details( $user_id, $project_key );
  
  # If invalid project_id passed
  $c->redirect_to('/projects') if ( !$project ); 
  

  # Might be change in future
  $c->stash( 'project' => $project) ;
  
  $c->render( template => 'admin/project_details');
}

1;