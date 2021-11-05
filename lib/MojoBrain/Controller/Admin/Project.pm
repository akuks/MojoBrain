package MojoBrain::Controller::Admin::Project;
use Mojo::Base 'Mojolicious::Controller', -signatures;

sub project ($c) {
  my $details  = $c->app->db->resultset('Client')->get_client_details( $c->session('user_id') );
  my $currency = $c->app->db->resultset('Currency')->get_all_currency();

  $c->stash( 'module'   => 'Projects' );
  $c->stash( 'details'  => $details );
  $c->stash( 'currency' => $currency );
  
  $c->render( template => '/admin/project')
}

sub project_post ($c) {
  my $v = $c->validation;

  my %options;

  # Form Validation Plugin
  foreach(qw/client_name name contract_type rate currency/) {
    $c->form_validation->{ $_ }->( $v ) ;
    $options { $_ } = $c->param( $_ );
  }

  $options { user_id } = $c->session( 'user_id' );
  print Data::Dumper::Dumper( $v );

  return $c->render( json => { error => 'Good'} );
  return $c->render ( json => { error => 'Invalid form parameters are passed.' } ) if ( $v->has_error );

  my $output;

  $output->{message} = 'Client added/updated succesfully.';
  $output->{status} = 200;

  $c->render( json => $output );
}

1;