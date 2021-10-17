package MojoBrain::Schema::ResultSet::User;
use strict;
use warnings;
use base 'DBIx::Class::ResultSet';

use Mojo::Base 'Mojolicious', -signatures;

sub create_user ( $self, $options ) {
  my $user;

  eval {
    $user = $self->create({ %$options });
  };

  return $@ ? 0 : $user;
}

# If User Already exists
sub is_user_exists ( $self, $email ) {
  my $user = $self->find({ email => $email });

  return $user ? $user : undef
}



1;