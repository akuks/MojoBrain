package MojoBrain::Controller::Auth::Profile;
use Mojo::Base 'Mojolicious::Controller', -signatures;
use JSON;
use Email::Valid;
use Trim;

# This action will render a template
sub profile ($c) {
  $c->render( template => 'auth/profile' )
}


sub profile_post ($c) {

  my $v = $c->validation;
  $v = $v->csrf_protect;

  return $c->render(text => 'Bad CSRF token!', status => 403) if $v->csrf_protect->has_error('csrf_token');

  return $c->redirect_to('/profile')
}

1;
