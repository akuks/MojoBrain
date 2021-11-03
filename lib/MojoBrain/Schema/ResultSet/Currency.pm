package MojoBrain::Schema::ResultSet::Currency;
use strict;
use warnings;
use base 'DBIx::Class::ResultSet';

use Mojo::Base 'Mojolicious', -signatures;

sub get_all_currency ( $self ) {
  my @currency = $self->search({}, { order_by => { -asc => 'country' } });

  my @details = map { {
      id         => $_->id,
      country    => $_->country,
      short_name => $_->short_name,
      code       => $_->code,
      symbol     => $_->symbol 
  } } @currency;

  return \@details
}

1;