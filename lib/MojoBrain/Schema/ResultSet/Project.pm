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
    { user_id => $user },
  );

  my @details = map { {
      name          => $_->project_name,
      contract_type => $_->contract_type,
      start_date    => $_->created_at->strftime("%b %d, %Y"),
      status        => $_->status,
      client_name   => $_->client->name,
      project_key   => $_->project_key
  } } @projects;

  return \@details
}

sub get_project_status_details_by_user ( $self, $user, $status ) {
  my @projects = $self->search(
    { user_id => $user, status => $status }
  );

  my @details = map { {
      name          => $_->project_name,
      contract_type => $_->contract_type,
      start_date    => $_->created_at->strftime("%b %d, %Y"),
      status        => $_->status,
      client_name   => $_->client->name,
      project_key   => $_->project_key
  } } @projects;

  return \@details
}

# get_individual_project_details
sub get_individual_project_details ( $self, $user, $project_key ) {
  my $project = $self->find(
    {
      project_key => $project_key, 
      user_id => $user
    }, 
    { prefetch => 'tasks' }
  );
  return $project;
}

1;