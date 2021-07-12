# Version 1.0
use strict;
use warnings;

use lib './local/lib/perl5/';
use DBI;

my $const_pass = '$2a$06$RDG2PkTXOVntQTbfWT/nZuINATrHcCa3YhKo69m0VPm6aqEuTyRWq';

print "Name of the database: ";
my $database = get_database_name();

print "Database username: ";
my $db_user = get_dbuser();

print "Database password: ";
my $db_pass = get_db_password();

my $dbh = get_db_handler($database, $db_user, $db_pass);

if (!$dbh) {
  die "\nfailed to connect to MySQL database DBI->errstr()\n";
}
else {
 print("\nConnected to DB server successfully.\n");
}

print "Enter the application admin username: ";
my $app_user = get_app_admin_user();

print "Application username: ", $app_user, "\n";

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

# Get database handler
sub get_db_handler {
  my ($database, $db_user, $db_pass) = @_;

  return DBI->connect("DBI:mysql:" . $database, $db_user, $db_pass);
}

# Application admin user
sub get_app_admin_user {
  my $app_user = <STDIN>;
  chomp($app_user);
  my $count = 0;

  while (!validate_app_user($app_user)) { # Only 4 attempts 
    print "Please enter a valid email id.\n";
    print "Enter the application admin username: ";
    $app_user = <STDIN>;
    chomp($app_user);
    $count++;
    exit if ( $count > 2 );
  }
  return $app_user
}

# Validate the Email ID
sub validate_app_user {
  my $app_user = shift;
  
  my $email_regex = '^([a-zA-Z][\w\_\.]{6,15})\@([a-zA-Z0-9.-]+)\.([a-zA-Z]{2,4})$';

  if($app_user=~ m/$email_regex/) {
    my $domain = $2;

    # Check if Domain starts or ends with -
    if($domain=~ /^\-|\-$/) { 
      print "Invalid domain name\n"; 
      return 0
    }

    # Check if Domain starts with digit
    if($domain=~ /^\d/) { 
      print "Invalid domain name\n"; 
      return 0
    }

    # If Domain name is not between 3 and 63
    if( length($domain) > 63 || length($domain) < 2) { 
      print "Invalid domain name\n"; 
      return 0
    }

    return 1

  }
  return 0 
}