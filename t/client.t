use Mojo::Base -strict;

use Test::More;
use Test::Mojo;

my $t = Test::Mojo->new('MojoBrain');
$t->ua->max_redirects(2);

my %creds = (
  username => 'kukreti.ashutosh@gmail.com',
  password => 'Ash123'
);

my %invalid_creds = (
  username => 'foo@gmail.com',
  password => 'Ash123'
);

my %client = (
  name => 'Test client',
  email => 'test@example.com',
  telephone => '9988331122'
);

my %invalid_client = (
  name => '',
  email => 'test@example.com',
  telephone => '9988331122'
);

subtest 'Test Client' => sub { 

  # redirect to login page if user is not login
  $t->get_ok('/clients')
    ->status_is(200)
    ->content_like(qr/Signin to/);

  # Test login with valid credentials
  $t->post_ok('/admin/login' => form => \%creds )
    ->status_is(200)
    ->content_like(qr/Total Income/);

  # Go to the clients url after login
  $t->get_ok('/clients')  
    ->status_is(200)
    ->content_like(qr/List of Clients/);

  # Register a new client with incorrect form details
  $t->post_ok('/clients' => form => \%invalid_client)
    ->status_is(201)
    ->json_is('/message' => 'Unable to create client.');

  # Register a new client with incorrect form details
  $t->post_ok('/clients' => form => \%client)
    ->status_is(201)
    ->json_is('/message' => 'client created succesfully.');

};



done_testing();
