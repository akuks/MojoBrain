package MojoBrain::Controller::Auth::Profile::SystemSetting;
use Mojo::Base 'Mojolicious::Controller', -signatures;
use Mojo::JSON qw(decode_json encode_json);
use Email::Valid;
use Trim;
use DateTime;
use DateTime::Format::MySQL;

# This action will render a template
sub system_setting ($c) {
  my $details = $c->app->db->resultset('CompanySetting')->get_company_details( $c->session('user_id') );
  
  $c->stash( 'module' => 'System-Settings' );
  $c->stash( 'details' => $details) ;
  
  $c->render( template => 'auth/profile/system_setting', title => 'Users System Settings' )
}

sub system_setting_post ($c) {
  my $v = $c->validation;

  my %options;

  # Form Validation Plugin
  foreach(qw/name email address city state zip country telephone_prefix telephone/) {
    if ( $_ eq 'email') {
      $c->form_validation->{ $_ }->( $v, $c->param('email') );
    }
    else {
      $c->form_validation->{ $_ }->( $v );
    }
    my $elem;
    $elem = ( $_ eq 'email') ? 'company_email' : $_;
    $options { $elem } = $c->param( $_ );
  }

  $options { user_id } = $c->session( 'user_id' );

  return $c->render ( json => { error => 'Invalid form parameters are passed.' } ) if ( $v->has_error );

  my $user_company = $c->app->db->resultset('CompanySetting')->create_update_company( \%options );

  my $output;

  $output->{message} = 'Company Settings updated succesfully.';
  $output->{status} = 200;

  $c->render( json => $output );
}

1;
