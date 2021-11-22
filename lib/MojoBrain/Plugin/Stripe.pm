package MojoBrain::Plugin::Stripe;
use Mojo::Base 'Mojolicious::Plugin', -signatures;

=head1 NAME Mojolicious Stripe Plugin

=cut

sub register ( $self, $app, $config ) {

  my ($secret_key, $publish_key);

  my $stripe = $app->db->resultset('Stripe')->search({});
  
  if ( $stripe->count ) {
    $stripe = $stripe->first;
    $secret_key = $stripe->secret_key;
    $publish_key = $stripe->publish_key;
  }

  return;
}


1;