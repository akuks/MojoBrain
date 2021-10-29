package MojoBrain::Schema::ResultSet::Client;
use strict;
use warnings;
use base 'DBIx::Class::ResultSet';

use Mojo::Base 'Mojolicious', -signatures;

sub create_update_client ( $self, $options ) {
  my $client;

  eval {
    $client = $self->update_or_create(
      { %$options },
      { key => 'client_id_user_id' }
    );
  };

  return $@ ? 0 : $client;
}

sub get_client_details ( $self, $user ) {
  my @clients = $self->search(
    { user_id => $user }
  );

  my @details = map { { 
    company => {
      name      => $_->name,
      email     => $_->email,
      status    => $_->status,
      telephone => $_->telephone
    }
  } } @clients;

  return \@details
}

1;