use utf8;
package MojoBrain::Schema::Result::Invoice;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MojoBrain::Schema::Result::Invoice

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

=head1 TABLE: C<invoice>

=cut

__PACKAGE__->table("invoice");

=head1 ACCESSORS

=head2 id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0

=head2 project_id

  data_type: 'integer'
  is_nullable: 0

=head2 invoice_id

  data_type: 'varchar'
  is_nullable: 0
  size: 40

=head2 invoice_type

  data_type: 'integer'
  is_nullable: 0

=head2 client_id

  data_type: 'integer'
  is_nullable: 0

=head2 status_invoice

  data_type: 'enum'
  extra: {list => ["draft","canceled","invoiced"]}
  is_nullable: 1

=head2 status_payment

  data_type: 'enum'
  extra: {list => ["unpaid","paid","partly_paid","partly_paid_and_credit_note","credit_note","overpaid"]}
  is_nullable: 1

=head2 amount

  data_type: 'double precision'
  is_nullable: 0
  size: [11,2]

=head2 additional_notes

  data_type: 'text'
  is_nullable: 1

=head2 invoice_issue_date

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 0

=head2 invoice_payment_last_date

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 created_at

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  default_value: 'CURRENT_TIMESTAMP'
  is_nullable: 0

=head2 updated_at

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  default_value: 'CURRENT_TIMESTAMP'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "bigint", is_auto_increment => 1, is_nullable => 0 },
  "project_id",
  { data_type => "integer", is_nullable => 0 },
  "invoice_id",
  { data_type => "varchar", is_nullable => 0, size => 40 },
  "invoice_type",
  { data_type => "integer", is_nullable => 0 },
  "client_id",
  { data_type => "integer", is_nullable => 0 },
  "status_invoice",
  {
    data_type => "enum",
    extra => { list => ["draft", "canceled", "invoiced"] },
    is_nullable => 1,
  },
  "status_payment",
  {
    data_type => "enum",
    extra => {
      list => [
        "unpaid",
        "paid",
        "partly_paid",
        "partly_paid_and_credit_note",
        "credit_note",
        "overpaid",
      ],
    },
    is_nullable => 1,
  },
  "amount",
  { data_type => "double precision", is_nullable => 0, size => [11, 2] },
  "additional_notes",
  { data_type => "text", is_nullable => 1 },
  "invoice_issue_date",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 0,
  },
  "invoice_payment_last_date",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  "created_at",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    default_value => "CURRENT_TIMESTAMP",
    is_nullable => 0,
  },
  "updated_at",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    default_value => "CURRENT_TIMESTAMP",
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

=head2 C<invoice_id>

=over 4

=item * L</invoice_id>

=back

=cut

__PACKAGE__->add_unique_constraint("invoice_id", ["invoice_id"]);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2021-12-01 19:58:53
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:BLAy2EM+T1032/3xyba4iw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
