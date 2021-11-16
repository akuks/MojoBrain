use utf8;
package MojoBrain::Schema::Result::Stripe;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MojoBrain::Schema::Result::Stripe

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=item * L<DBIx::Class::TimeStamp>

=item * L<DBIx::Class::EncodedColumn>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp", "EncodedColumn");

=head1 TABLE: C<stripe>

=cut

__PACKAGE__->table("stripe");

=head1 ACCESSORS

=head2 publish_key

  data_type: 'text'
  is_nullable: 0

=head2 secret_key

  data_type: 'text'
  is_nullable: 0

=head2 user_id

  data_type: 'bigint'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "publish_key",
  { data_type => "text", is_nullable => 0 },
  "secret_key",
  { data_type => "text", is_nullable => 0 },
  "user_id",
  { data_type => "bigint", is_nullable => 1 },
);

=head1 UNIQUE CONSTRAINTS

=head2 C<user_id>

=over 4

=item * L</user_id>

=back

=cut

__PACKAGE__->add_unique_constraint("user_id", ["user_id"]);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2021-11-16 19:10:20
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:PMkrS6tVwIw11U8c3OoPiA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
