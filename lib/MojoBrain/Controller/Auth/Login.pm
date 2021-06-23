package MojoBrain::Controller::Auth::Login;
use Mojo::Base 'Mojolicious::Controller', -signatures;
use JSON;

# This action will render a template
sub login ($c) {

  # Render template "example/welcome.html.ep" with message
  $c->render(msg => 'Welcome to the Mojolicious real-time web framework!');
}

1;
