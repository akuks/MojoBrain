package MojoBrain::Controller::Admin::Post;
use Mojo::Base 'Mojolicious::Controller', -signatures;

sub get_post($c) {
  my $user = $c->app->get_user_details;

  $c->render(template => 'admin/post', user => $user);
}

1;