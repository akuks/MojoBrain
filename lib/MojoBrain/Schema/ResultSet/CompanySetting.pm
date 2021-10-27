package MojoBrain::Schema::ResultSet::CompanySetting;
use strict;
use warnings;
use base 'DBIx::Class::ResultSet';

use Mojo::Base 'Mojolicious', -signatures;

sub create_update_company ( $self, $options ) {
  my $company;

  eval {
    $company = $self->update_or_create(
      { %$options },
      { key => { 'user_id' } }
    );
  };

  return $@ ? 0 : $company;
}

1;