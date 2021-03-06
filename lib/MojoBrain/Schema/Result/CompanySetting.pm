use utf8;
package MojoBrain::Schema::Result::CompanySetting;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MojoBrain::Schema::Result::CompanySetting

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

=head1 TABLE: C<company_setting>

=cut

__PACKAGE__->table("company_setting");

=head1 ACCESSORS

=head2 company_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 300

=head2 address

  data_type: 'mediumtext'
  is_nullable: 1

=head2 city

  data_type: 'varchar'
  is_nullable: 1
  size: 40

=head2 state

  data_type: 'varchar'
  is_nullable: 1
  size: 20

=head2 zip

  data_type: 'varchar'
  is_nullable: 1
  size: 20

=head2 company_email

  data_type: 'varchar'
  is_nullable: 1
  size: 200

=head2 user_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 created_at

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=head2 updated_at

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 company_secret_key

  data_type: 'varchar'
  is_nullable: 1
  size: 80

=head2 country

  data_type: 'varchar'
  is_nullable: 1
  size: 20

=head2 telephone

  data_type: 'varchar'
  is_nullable: 1
  size: 20

=head2 telephone_prefix

  data_type: 'varchar'
  is_nullable: 1
  size: 4

=cut

__PACKAGE__->add_columns(
  "company_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 300 },
  "address",
  { data_type => "mediumtext", is_nullable => 1 },
  "city",
  { data_type => "varchar", is_nullable => 1, size => 40 },
  "state",
  { data_type => "varchar", is_nullable => 1, size => 20 },
  "zip",
  { data_type => "varchar", is_nullable => 1, size => 20 },
  "company_email",
  { data_type => "varchar", is_nullable => 1, size => 200 },
  "user_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
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
  "company_secret_key",
  { data_type => "varchar", is_nullable => 1, size => 80 },
  "country",
  { data_type => "varchar", is_nullable => 1, size => 20 },
  "telephone",
  { data_type => "varchar", is_nullable => 1, size => 20 },
  "telephone_prefix",
  { data_type => "varchar", is_nullable => 1, size => 4 },
);

=head1 PRIMARY KEY

=over 4

=item * L</company_id>

=back

=cut

__PACKAGE__->set_primary_key("company_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<user_id>

=over 4

=item * L</user_id>

=back

=cut

__PACKAGE__->add_unique_constraint("user_id", ["user_id"]);

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


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2021-10-27 21:13:10
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:fjQZmSqrX/KZqnvFgvHsTA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
