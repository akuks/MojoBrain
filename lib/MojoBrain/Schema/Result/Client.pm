use utf8;
package MojoBrain::Schema::Result::Client;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MojoBrain::Schema::Result::Client

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

=head1 TABLE: C<client>

=cut

__PACKAGE__->table("client");

=head1 ACCESSORS

=head2 client_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 user_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 200

=head2 email

  data_type: 'varchar'
  is_nullable: 0
  size: 200

=head2 status

  data_type: 'integer'
  default_value: 1
  is_nullable: 0

=head2 telephone

  data_type: 'varchar'
  is_nullable: 1
  size: 20

=head2 created_at

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=head2 updated_at

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 company_name

  data_type: 'varchar'
  is_nullable: 1
  size: 200

=cut

__PACKAGE__->add_columns(
  "client_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "user_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 200 },
  "email",
  { data_type => "varchar", is_nullable => 0, size => 200 },
  "status",
  { data_type => "integer", default_value => 1, is_nullable => 0 },
  "telephone",
  { data_type => "varchar", is_nullable => 1, size => 20 },
  "created_at",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => \"current_timestamp",
    is_nullable => 0,
  },
  "updated_at",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  "company_name",
  { data_type => "varchar", is_nullable => 1, size => 200 },
);

=head1 PRIMARY KEY

=over 4

=item * L</client_id>

=back

=cut

__PACKAGE__->set_primary_key("client_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<client_email>

=over 4

=item * L</email>

=back

=cut

__PACKAGE__->add_unique_constraint("client_email", ["email"]);

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


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2021-11-01 15:04:35
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:3X+KGWJ2cDO3i3fI++Zxmw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
