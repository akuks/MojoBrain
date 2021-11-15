use utf8;
package MojoBrain::Schema::Result::Task;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MojoBrain::Schema::Result::Task

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

=head1 TABLE: C<task>

=cut

__PACKAGE__->table("task");

=head1 ACCESSORS

=head2 task_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0

=head2 project_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 title

  data_type: 'varchar'
  is_nullable: 0
  size: 100

=head2 description

  data_type: 'text'
  is_nullable: 1

=head2 due_date

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  is_nullable: 1

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
  extra: {list => ["Incomplete","Completed","Archived"]}
  is_nullable: 1

=head2 created_by

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 updated_by

  data_type: 'bigint'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "task_id",
  { data_type => "bigint", is_auto_increment => 1, is_nullable => 0 },
  "project_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "title",
  { data_type => "varchar", is_nullable => 0, size => 100 },
  "description",
  { data_type => "text", is_nullable => 1 },
  "due_date",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
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
    extra => { list => ["Incomplete", "Completed", "Archived"] },
    is_nullable => 1,
  },
  "created_by",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "updated_by",
  { data_type => "bigint", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</task_id>

=back

=cut

__PACKAGE__->set_primary_key("task_id");

=head1 RELATIONS

=head2 created_by

Type: belongs_to

Related object: L<MojoBrain::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "created_by",
  "MojoBrain::Schema::Result::User",
  { user_id => "created_by" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);

=head2 project

Type: belongs_to

Related object: L<MojoBrain::Schema::Result::Project>

=cut

__PACKAGE__->belongs_to(
  "project",
  "MojoBrain::Schema::Result::Project",
  { project_id => "project_id" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2021-11-06 17:50:47
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:UaCLV5P25MsXNWzTF3si5Q


# You can replace this text with custom code or comments, and it will be preserved on regeneration

__PACKAGE__->add_unique_constraint("task_id", ["task_id"]);

1;
