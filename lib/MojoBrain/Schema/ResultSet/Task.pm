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
        { key => 'task_id' }
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

# Update Task Status
sub update_task_status ( $self, $status, $task_id, $project_key ) {
  my $task = $self->search({
    task_id => $task_id
  });

  if ( $task->count ) {
    $task = $task->first;

    my $task_project_key  = $task->project->project_key;
    return 0 if ( $task_project_key ne $project_key ); # If invalid project key is passed

    eval {
      $task->update({
        status => $status
      });
    };
    return $@ ? 0 : $task
  }
  return 0
}

1;