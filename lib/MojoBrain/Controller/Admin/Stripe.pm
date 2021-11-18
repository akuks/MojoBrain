package MojoBrain::Controller::Admin::Stripe;
use Mojo::Base 'Mojolicious::Controller', -signatures;

sub stripe ( $c ) {
  $c->stash( 'module' => 'Stripe' );

  $c->stash ( 'stripe' => sub {
    my $stripe = $c->app->db->resultset( 'Stripe' )->find(
      { user_id => $c->session( 'user_id' ) }
    );
    return $stripe;
  } );

  $c->render( template => 'admin/stripe' );
}

sub update_stripe ( $c ) {

  my $publish_key = $c->param( 'publish_key' );
  my $secret_key  = $c->param( 'private_key' );

  my %options = (
    publish_key => $c->param( 'publish_key' ),
    secret_key  => $c->param( 'secret_key' ),
    user_id     => $c->session('user_id')
  );

  return $c->render( error => 'Private and Publish keys cannot be left blank or null' ) 
    if ( !$options { publish_key } or !$options { secret_key });

  my $output;

  eval {
    $c->app->db->resultset('Stripe')->update_or_create({ %options });
  };

  # If Stripe keys not updated
  return $c->render ( json => { message => 'Failed to update stripe keys' } ) if $@;

  $output->{ message } = 'Stripe Keys updated succesfully.';
  $output->{ status } = 200;

  $c->render( json => $output );

}


1;