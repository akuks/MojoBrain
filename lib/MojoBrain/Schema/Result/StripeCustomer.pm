use utf8;
package MojoBrain::Schema::Result::StripeCustomer;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MojoBrain::Schema::Result::StripeCustomer

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

=head1 TABLE: C<stripe_customers>

=cut

__PACKAGE__->table("stripe_customers");

=head1 ACCESSORS

=head2 id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0

=head2 stripe_customer_id

  data_type: 'varchar'
  is_nullable: 0
  size: 200

=head2 user_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 status

  data_type: 'integer'
  default_value: 1
  is_nullable: 1

=head2 created_at

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  default_value: 'CURRENT_TIMESTAMP'
  is_nullable: 1

=head2 updated_at

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "bigint", is_auto_increment => 1, is_nullable => 0 },
  "stripe_customer_id",
  { data_type => "varchar", is_nullable => 0, size => 200 },
  "user_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "status",
  { data_type => "integer", default_value => 1, is_nullable => 1 },
  "created_at",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    default_value => "CURRENT_TIMESTAMP",
    is_nullable => 1,
  },
  "updated_at",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<streip_customer_user_id>

=over 4

=item * L</stripe_customer_id>

=item * L</user_id>

=back

=cut

__PACKAGE__->add_unique_constraint("streip_customer_user_id", ["stripe_customer_id", "user_id"]);

=head2 C<stripe_customer_id>

=over 4

=item * L</stripe_customer_id>

=back

=cut

__PACKAGE__->add_unique_constraint("stripe_customer_id", ["stripe_customer_id"]);

=head1 RELATIONS

=head2 user

Type: belongs_to

Related object: L<MojoBrain::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "user",
  "MojoBrain::Schema::Result::User",
  { user_id => "user_id" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2021-11-22 23:13:27
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:e+gWQst+JeFaPewXfuEBpA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
