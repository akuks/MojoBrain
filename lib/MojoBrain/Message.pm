package MojoBrain::Message;

use Moo;
use strictures 2;
use namespace::clean;

use constant INVALID_CRED => 'Invalid username or password';

sub get_invalid_credentials_message {
  return INVALID_CRED
}

1;