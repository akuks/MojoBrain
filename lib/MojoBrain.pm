package MojoBrain;
use Mojo::Base 'Mojolicious', -signatures;

use Mojo::JWT;
use MojoBrain::Message;
use MojoBrain::Model::DB;

# This method will run once at server start
sub startup ($self) {

  # Load configuration from config file
  my $config = $self->plugin('NotYAMLConfig');

  $self->plugin('Bcrypt');

  my $api_file = $config->{apifile}->[0];

  # Configure the application
  $self->secrets($config->{secrets});
  $self->_set_hooks();

  my $mode = $self->mode;
  my $database = $config->{app}->{mode}->{$mode}->{database};

  $self->helper( db => sub { return MojoBrain::Model::DB->new( $database ) }); # Database Handler
  $self->helper( msg => sub { MojoBrain::Message->new() }); #Message Handler
  $self->helper( jwt => sub { Mojo::JWT->new(secret => shift->app->secrets->[0] || die) } ); # Token Handler

  # Normal route to controller
  $self->plugin(
    OpenAPI => { 
      schema => 'v3',
      url     => $self->home->rel_file($api_file),
    }
  );

  my $r = $self->routes;

  $r->get('/admin/login')->to('Admin::Auth#signin');
  $r->post('/admin/login')->to('Admin::Auth#signin_post');
}

sub _set_hooks {
  my $self = shift;

  $self->hook(after_dispatch => sub {
    my $c = shift;
    
    $c->res->headers->header('Access-Control-Allow-Origin' => '*');
    $c->res->headers->access_control_allow_origin('*');
    $c->res->headers->header('Access-Control-Allow-Methods' => 'GET, OPTIONS, POST, DELETE, PUT');
    $c->res->headers->header('Access-Control-Allow-Headers' => '*');
    $c->res->headers->header('Accept-Encoding' => 'br');
    $c->app->renderer->compress(1);
  });

  return $self;
}


1;
