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

=head2 currency_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 currency_name

  data_type: 'varchar'
  is_nullable: 0
  size: 20

=head2 symbol

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "currency_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "currency_name",
  { data_type => "varchar", is_nullable => 0, size => 20 },
  "symbol",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</currency_id>

=back

=cut

__PACKAGE__->set_primary_key("currency_id");


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2021-11-03 14:07:18
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:nSDswhZ4n0aOCT/DqiqJ2w


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
