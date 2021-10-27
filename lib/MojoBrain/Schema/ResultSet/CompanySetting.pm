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
      { key => 'user_id' }
    );
  };

  return $@ ? 0 : $company;
}

sub get_company_details ( $self, $user ) {
  my $company = $self->search(
    { user_id => $user }
  );

  return 0 if !$company->count;

  my @details = map { { 
    company => {
      name      => $_->name,
      email     => $_->company_email,
      address   => $_->address,
      city      => $_->city,
      state     => $_->state,
      zip       => $_->zip,
      country   => $_->country,
      prefix    => $_->telephone_prefix,
      telephone => $_->telephone
    }
  } } $company->first;

  return $details[0]
} 

1;