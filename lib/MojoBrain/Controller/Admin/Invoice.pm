package MojoBrain::Controller::Admin::Invoice;
use Mojo::Base 'Mojolicious::Controller', -signatures;

sub index ( $c ) {
  
  $c->stash( 'module' => 'Invoices' );

  $c->render( template => 'admin/invoice/index' );
}


1;