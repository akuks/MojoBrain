package MojoBrain::Schema::ResultSet::Project;
use strict;
use warnings;
use base 'DBIx::Class::ResultSet';

use Mojo::Base 'Mojolicious', -signatures;

sub create_update_project ( $self, $options ) {
  my $project;

  if ( $options->{ project_id } ) {
    # When project needs to be updated
    eval {
      $project = $self->update_or_create(
        { %$options },
        { key => 'project_id' }
      );
    };
  }
  else {
    # For newly created projects
    eval {
      $project = $self->create(
        { %$options }
      );
    };
  }

  return $@ ? 0 : $project;
}

sub get_project_details_by_user ( $self, $user ) {
  my @projects = $self->search(
    { user_id => $user }
  );

  my @details = map { {
      name         => $_->name,
      email        => $_->email,
      status       => $_->status,
      telephone    => $_->telephone,
      company_name => $_->company_name,
      client_id    => $_->client_id
  } } @projects;

  return \@details
}

1;