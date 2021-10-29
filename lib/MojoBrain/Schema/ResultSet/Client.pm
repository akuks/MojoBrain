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

1;