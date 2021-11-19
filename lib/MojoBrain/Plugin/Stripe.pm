package MojoBrain::Plugin::Stripe;
use Mojo::Base 'Mojolicious::Plugin', -signatures;

=head1 NAME Mojolicious Stripe Plugin

=cut

sub register ( $self, $app, $config ) {

  print Data::Dumper::Dumper( $app ); 

  return;
}


1;