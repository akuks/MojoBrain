package MojoBrain::Model::DB;
use strict;

use MojoBrain::Schema;
use DBIx::Class();

sub new {
  my ($class, $db_cred) = @_;
  my $schema_class = $db_cred->{schema};
  my $connect_info = {
    dsn      => $db_cred->{dsn},
    user     => $db_cred->{user},
    password => $db_cred->{password},
  }; 
  
  return __PACKAGE__->config($schema_class, $connect_info);
}

sub config {
  my $class = shift;

  my $self = {
    schema           => shift,
    connect_info     => shift
  };

  my $dbh = $self->{schema}->connect(
    $self->{connect_info}->{dsn}, 
    $self->{connect_info}->{user}, 
    $self->{connect_info}->{password}
  );

  return $dbh;
}


1;