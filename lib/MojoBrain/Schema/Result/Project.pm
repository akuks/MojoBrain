use utf8;
package MojoBrain::Schema::Result::Project;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MojoBrain::Schema::Result::Project

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

=head1 TABLE: C<project>

=cut

__PACKAGE__->table("project");

=head1 ACCESSORS

=head2 project_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 client_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 currency_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 user_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 project_name

  data_type: 'varchar'
  is_nullable: 1
  size: 150

=head2 contract_type

  data_type: 'enum'
  extra: {list => ["fixed","hourly"]}
  is_nullable: 1

=head2 rate

  data_type: 'decimal'
  is_nullable: 0
  size: [25,2]

=head2 created_at

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 1

=head2 updated_at

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 status

  data_type: 'enum'
  extra: {list => ["Active","In Progress","On Hold","Closed","Completed"]}
  is_nullable: 1

=head2 project_key

  data_type: 'varchar'
  is_nullable: 1
  size: 80

=cut

__PACKAGE__->add_columns(
  "project_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "client_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "currency_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "user_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "project_name",
  { data_type => "varchar", is_nullable => 1, size => 150 },
  "contract_type",
  {
    data_type => "enum",
    extra => { list => ["fixed", "hourly"] },
    is_nullable => 1,
  },
  "rate",
  { data_type => "decimal", is_nullable => 0, size => [25, 2] },
  "created_at",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => \"current_timestamp",
    is_nullable => 1,
  },
  "updated_at",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  "status",
  {
    data_type => "enum",
    extra => {
      list => ["Active", "In Progress", "On Hold", "Closed", "Completed"],
    },
    is_nullable => 1,
  },
  "project_key",
  { data_type => "varchar", is_nullable => 1, size => 80 },
);

=head1 PRIMARY KEY

=over 4

=item * L</project_id>

=back

=cut

__PACKAGE__->set_primary_key("project_id");

=head1 RELATIONS

=head2 client

Type: belongs_to

Related object: L<MojoBrain::Schema::Result::Client>

=cut

__PACKAGE__->belongs_to(
  "client",
  "MojoBrain::Schema::Result::Client",
  { client_id => "client_id" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);

=head2 currency

Type: belongs_to

Related object: L<MojoBrain::Schema::Result::Currency>

=cut

__PACKAGE__->belongs_to(
  "currency",
  "MojoBrain::Schema::Result::Currency",
  { id => "currency_id" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);

=head2 tasks

Type: has_many

Related object: L<MojoBrain::Schema::Result::Task>

=cut

__PACKAGE__->has_many(
  "tasks",
  "MojoBrain::Schema::Result::Task",
  { "foreign.project_id" => "self.project_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

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


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2021-11-06 17:50:47
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:wACdPeiePGFfp1kaeHJy6A


# You can replace this text with custom code or comments, and it will be preserved on regeneration

=head1 UNIQUE CONSTRAINTS

=head2 C<project_id>

=over 4

=item * L</project_id>

=back

=cut

__PACKAGE__->add_unique_constraint("project_id", ["project_id"]);


1;
