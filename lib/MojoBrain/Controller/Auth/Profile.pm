package MojoBrain::Controller::Auth::Profile;
use Mojo::Base 'Mojolicious::Controller', -signatures;
use Mojo::JSON qw(decode_json encode_json);
use Email::Valid;
use Trim;
use DateTime;
use DateTime::Format::MySQL;

# This action will render a template
sub profile ($c) {
  $c->stash( 'module' => 'Profile' );
  $c->render( template => 'auth/profile', title => 'User Profile' )
}

sub profile_post ($c) {
  my $output ;

  my $v = $c->validation;
  $v = $v->csrf_protect;
  
  return $c->render(text => 'Bad CSRF token!', status => 403) 
    if $v->csrf_protect->has_error('csrf_token');

  $v->required('name')->like(q/[a-zA-Z]/);
  $v->required('email')->like( Email::Valid->address( $c->param('email') ) );
  $v->optional('user_bio')->check_length(200);
  $v->optional('website')->is_url();
  $v->optional('twitter')->is_url();
  $v->optional('facebook')->is_url();
  $v->optional('linkedin')->is_url();
  $v->optional('dev_to')->is_url();

  # Validation Errors
  if ( $v->has_error ) {
    $output->{ error } = {
      name     => $v->has_error('name') ? 'Invalid Name' : '',
      email    => $v->has_error('email') ? 'Invalid Email ID' : '',
      user_bio => $v->has_error('user_bio') ? 'User bio must be less than 200' : '',
      website  => $v->has_error('website') ? 'Invalid Url' : '',
      twitter  => $v->has_error('twitter') ? 'Invalid Url' : '',
      facebook => $v->has_error('facebook') ? 'Invalid Url' : '',
      linkedin => $v->has_error('linkedin') ? 'Invalid Url' : '',
      dev_to   => $v->has_error('dev-to') ? 'Invalid Url' : '',
    };
    return $c->render ( json =>  $output  ) if $v->has_error;
  }
  
  my $slug = $c->param('name');
  $slug =~ s/ +//g;
  
  my $dt = DateTime->now;

  my %options = (
    name       => trim $c->param('name'),
    email      => trim $c->param('email'),
    user_bio   => trim $c->param('user_bio'),
    website    => trim $c->param('website'),
    twitter    => trim $c->param('twitter'),
    facebook   => trim $c->param('facebook'),
    linkedin   => trim $c->param('linkedin'),
    dev_to     => trim $c->param('dev_to'),
    slug       => $slug,
    updated_by => $c->param('created_by') ? trim $c->param('created_by') : 'Self',
    updated_at =>  DateTime::Format::MySQL->format_datetime( $dt )
  );

  my $user = $c->app->db->resultset('User')->update_user( $c->session( 'user_id' ), \%options ); 

  return $c->render ( json => { error => 'Generic API Error.'  }  ) if !$user;

  $output->{user}    = $user;
  $output->{message} = 'Profile updated succesfully.';
  $output->{status}  = 200;

  return $c->render ( json =>  $output  );
}

sub change_password_post ($c) {
  my $v = $c->validation;

  # Form Validation
  $c->change_password_form_validation->{password}->($v);

  return $c->render ( json => { error => 'Invalid password request.' } ) if ( $v->has_error );

  my $user = $c->app->db->resultset('User')->get_user_by_id( $c->session( 'user_id' ) ); 

  # If Invalid user_id
  return $c->render( json => { error => 'Generic API error.' } ) if ( !$user->count ); 

  my $is_pass_valid = $c->bcrypt_validate( $c->param('password') || '', $user->first->password ) ;

  # Invalid current password
  return $c->render ( json => { error => 'Invalid current password.' } ) if ( !$is_pass_valid );

  eval {
    $user->update({ 
      password => trim $c->app->bcrypt( $c->param('new_password') ) ,
      updated_at =>  DateTime::Format::MySQL->format_datetime( DateTime->now )
    });
  } ;

  my $output;

  if ($@) {
    $output->{ error } = 'Failed to update password';
  }
  else {
    $output->{message} = 'Password updated succesfully.';
    $output->{status}  = 200;
  }

  return $c->render ( json =>  $output  );
}

1;
