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

  return;
}

1;