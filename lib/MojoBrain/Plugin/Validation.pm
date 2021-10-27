package MojoBrain::Plugin::Validation;
use Mojo::Base 'Mojolicious::Plugin', -signatures;

sub register ($self, $app, $config) {

  # check the length of the string
  $app->validator->add_check( check_length => sub ( $v, $name, $value, $max ) {
    return length( $value ) > $max;
  });

  # Check if its a valid url
  $app->validator->add_check( is_url => sub ( $v, $name, $value ) {
    return if ( !$value );

    return 'Invalid URL format' if ( $value !~ /^(?:(?:https?|s?))/ );
  });

  # Change Password Form Validation
  $app->helper ( 'change_password_form_validation' => sub ($c) {
    return state $change_password_form_validation = {
      password => sub ( $v ) {
        $v->required( 'password' )->like( qr/^[a-zA-Z0-9]+$/ );
        $v->required( 'new_password' )->like( qr/^[a-zA-Z0-9]+$/ );
        $v->required( 'confirm_new_password' )->like( qr/^[a-zA-Z0-9]+$/ );
        $v->required( 'confirm_new_password' )->equal_to( 'new_password' ) if $v->required( 'password' )->is_valid;
      }
    }
  });

  # General Form Validation
  $app->helper( 'form_validation' => sub ( $c ) {
    return state $form_validation = {
      name => sub ( $v ) {
        $v->required('name')->like( qr/^[a-zA-Z0-9 ]+$/ );
      },
      email => sub ( $v, $email ) {
        $v->required('email')->like( Email::Valid->address( $email ) )
      },
      address => sub ( $v ) {
        $v->optional('address')->like( qr/^[a-zA-Z0-9\/]+$/ );
      },
      city => sub ( $v ) {
        $v->optional('city')->like( qr/^[a-zA-Z]+$/ );
      },
      state => sub ( $v ) {
        $v->optional('state')->like( qr/^[a-zA-Z ]+$/ );
      },
      zip => sub ( $v ) {
        $v->optional('zip')->like( qr/^[0-9]+$/ );
      },
      country => sub ( $v ) {
        $v->optional('country')->like( qr/^[a-zA-Z]+$/ );
      },
      telephone_prefix => sub ( $v ) {
        # Must be 2 or 3 digits
        $v->optional('telephone_prefix')->like( qr/^$|^[\+]?[0-9]?[0-9]?[0-9]$/ );
      },
      telephone => sub ( $v ) {
        $v->optional('telephone')->like( qr/^[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$/ );
      }
    }
  });

  return;
}

1;