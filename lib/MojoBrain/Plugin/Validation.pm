package MojoBrain::Plugin::Validation;
use Mojo::Base 'Mojolicious::Plugin', -signatures;
#use Mojolicious::Validator;

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
        $v->required('name')->like( qr/^[a-zA-Z0-9]+$/ );
      },
      email => sub ( $v, $email ) {
        $v->required('email')->like( Email::Valid->address( $email ) )
      }
    }
  });

  return;
}

1;