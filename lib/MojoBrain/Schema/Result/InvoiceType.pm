use utf8;
package MojoBrain::Schema::Result::InvoiceType;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MojoBrain::Schema::Result::InvoiceType

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

=head1 TABLE: C<invoice_type>

=cut

__PACKAGE__->table("invoice_type");

=head1 ACCESSORS

=head2 invoice_type_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 type

  data_type: 'varchar'
  is_nullable: 0
  size: 20

=cut

__PACKAGE__->add_columns(
  "invoice_type_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "type",
  { data_type => "varchar", is_nullable => 0, size => 20 },
);

=head1 PRIMARY KEY

=over 4

=item * L</invoice_type_id>

=back

=cut

__PACKAGE__->set_primary_key("invoice_type_id");


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2021-11-15 21:12:48
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:M/5a6PYK+XHd4T0UoZBOew


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
