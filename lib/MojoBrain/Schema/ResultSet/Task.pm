package MojoBrain::Schema::ResultSet::Task;
use strict;
use warnings;
use base 'DBIx::Class::ResultSet';

use Mojo::Base 'Mojolicious', -signatures;

sub create_update_task ( $self, $options ) {
  my $task;

  if ( $options->{ task_id } ) {
    # When project needs to be updated
    eval {
      $task = $self->update_or_create(
        { %$options },
        { key => 'project_id' }
      );
    };
  }
  else {
    # For newly created task
    eval {
      $task = $self->create(
        { %$options }
      );
    };
  }
  
  return $@ ? 0 : $task;
}

sub get_task_by_project_id ( $self, $project_id, $title, $user_id ) {
  my $task = $self->find({
    project_id => $project_id,
    title      => $title,
    created_by => $user_id
  });

  # If not defined it'll return undef
  return $task; 
}

1;