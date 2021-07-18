package MojoBrain::Controller::Admin::Dashboard;
use Mojo::Base 'Mojolicious::Controller', -signatures;

sub dashboard($c) {
  my $user = $c->get_user_details;
  
  $c->render(template => 'admin/dashboard', user => $user);
}

# Subroutines
sub get_user_details($c) {
  return $c->session('user_id') ? $c->db->resultset('User')->search({
    user_id => $c->session('user_id')
  })->first : '';
}

1;