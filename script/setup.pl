# Version 1.0
use strict;
use warnings;

print "Name of the database: ";
my $database = get_database_name();

print "Database username: ";
my $dbuser = get_dbuser();

print "Database password: ";
my $db_pass = get_db_password();

print "\nName of the database is ", $database, "\n";

# subroutines

sub get_database_name {
  my $db = <STDIN>;
  chomp($db);
  return $db;
}

sub get_dbuser {
  my $db_user = <STDIN>;
  chomp($db_user);
  return $db_user
}

sub get_db_password {
  system ("stty -echo"); # Hide user password
  my $db_pass = <STDIN>;
  chomp($db_pass);
  system ("stty echo");
  return $db_pass;
}