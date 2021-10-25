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

1;
