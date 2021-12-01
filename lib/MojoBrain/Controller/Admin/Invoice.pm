package MojoBrain::Controller::Admin::Invoice;
use Mojo::Base 'Mojolicious::Controller', -signatures;

sub show_invoice ( $c ) {
  
  $c->render( template => 'admin/invoice/index' );
}


1;