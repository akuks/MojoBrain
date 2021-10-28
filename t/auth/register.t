use Mojo::Base -strict;

use Test::More;
use Test::Mojo;

my $t = Test::Mojo->new('MojoBrain');
$t->ua->max_redirects(2);

my %creds = (
  username => 'kukreti.ashutosh@gmail.com',
  password => 'Ash123'
);

subtest 'Test User Registration' => sub { 

  # If Login Form exists
  $t->get_ok('/signup')
    ->status_is(200)
    ->element_exists('form input[name="name"]')
    ->element_exists('form input[name="password"]')
    ->element_exists('form input[name="confirm_password"]')
    ->element_exists('form button[type="submit"]');

};

done_testing();
