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

subtest 'Test Login' => sub { 
  # Login Page must be loaded
  $t->get_ok('/admin/login')->status_is(200)->content_like(qr/Signin to/i);

  # If Login Form exists
  $t->get_ok('/admin/login')
    ->status_is(200)
    ->element_exists('form input[name="username"]')
    ->element_exists('form input[name="password"]')
    ->element_exists('form button[type="submit"]');

  # Test login with invalid credentials
  $t->post_ok('/admin/login' => form => \%invalid_creds )
    ->status_is(200)
    ->content_like(qr/Signin to/i);

  # Test login with valid credentials
  $t->post_ok('/admin/login' => form => \%creds )
    ->status_is(200)
    ->content_like(qr/Total Income/);
};

done_testing();
