package MojoBrain::Plugin::Message;
use Mojo::Base 'Mojolicious::Plugin', -signatures;

sub register ($self, $app, $config) {
  my %message;
  $app->helper( message => sub ( $v, $key ) {
    return $message { $key };
  });

  return;
}

1;