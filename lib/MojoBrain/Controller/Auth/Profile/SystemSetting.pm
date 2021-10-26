package MojoBrain::Controller::Auth::Profile::SystemSetting;
use Mojo::Base 'Mojolicious::Controller', -signatures;
use Mojo::JSON qw(decode_json encode_json);
use Email::Valid;
use Trim;
use DateTime;
use DateTime::Format::MySQL;

# This action will render a template
sub system_setting ($c) {
  $c->stash( 'module' => 'System-Setting' );
  $c->render( template => 'auth/profile/system_setting', title => 'Users System Settings' )
}

sub system_setting_post ($c) {
  my $v = $c->validation;

  # Form Validation Plugin
  foreach(qw/name email address city state zip country telephone_prefix telephone/) {
    if ( $_ eq 'email') {
      $c->form_validation->{$_}->( $v, $c->param('email') );
    }
    else {
      $c->form_validation->{$_}->( $v );
    }
  }

  return $c->render ( json => { error => 'Invalid form parameters are passed.' } ) if ( $v->has_error );

  my $output ;
  print Data::Dumper::Dumper ( $v );

  $output->{message} = 'Company Settings updated succesfully.';
  $output->{status} = 200;

  $c->render( json => $output );
}

1;
