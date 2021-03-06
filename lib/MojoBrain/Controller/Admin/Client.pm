package MojoBrain::Controller::Admin::Client;
use Mojo::Base 'Mojolicious::Controller', -signatures;

sub client ($c) {
  my $details = $c->app->db->resultset('Client')->get_client_details( $c->session('user_id') );

  $c->stash( 'module' => 'Clients' );
  $c->stash( 'details' => $details );
  
  $c->render( template => '/admin/client')
}

sub client_post ($c) {
  my $v = $c->validation;

  my %options;

  # Form Validation Plugin
  foreach(qw/company_name name email telephone/) {
    if ( $_ eq 'email') {
      $c->form_validation->{ $_ }->( $v, $c->param('email') );
    }
    else {
      $c->form_validation->{ $_ }->( $v );
    }

    $options { $_ } = $c->param( $_ );
  }

  $options { user_id } = $c->session( 'user_id' );

  return $c->render ( json => { error => 'Invalid form parameters are passed.' } ) if ( $v->has_error );

  my $user_company = $c->app->db->resultset('Client')->create_update_client( \%options );

  my $output;
  if ( $user_company ) {
    $output->{message} = 'Client added/updated succesfully.';
    $output->{status} = 200;
  }
  else {
    $output->{error} = 'Failed to add/update client.';
  }

  $c->render( json => $output );
}

1;