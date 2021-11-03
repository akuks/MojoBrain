use utf8;
package MojoBrain::Schema::Result::Currency;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MojoBrain::Schema::Result::Currency

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

=head1 TABLE: C<currency>

=cut

__PACKAGE__->table("currency");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 country

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 short_name

  data_type: 'varchar'
  is_nullable: 1
  size: 100

=head2 code

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 min

  data_type: 'integer'
  is_nullable: 1

=head2 symbol

  data_type: 'varchar'
  is_nullable: 1
  size: 30

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "country",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "short_name",
  { data_type => "varchar", is_nullable => 1, size => 100 },
  "code",
  { data_type => "varchar", is_nullable => 1, size => 50 },
  "min",
  { data_type => "integer", is_nullable => 1 },
  "symbol",
  { data_type => "varchar", is_nullable => 1, size => 30 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 projects

Type: has_many

Related object: L<MojoBrain::Schema::Result::Project>

=cut

__PACKAGE__->has_many(
  "projects",
  "MojoBrain::Schema::Result::Project",
  { "foreign.currency_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2021-11-03 16:44:20
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:6r51nenwt4yWP4ST8yjjHA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
