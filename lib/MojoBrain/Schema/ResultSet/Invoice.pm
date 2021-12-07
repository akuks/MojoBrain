package MojoBrain::Schema::ResultSet::Invoice;
use strict;
use warnings;
use base 'DBIx::Class::ResultSet';

use Mojo::Base 'Mojolicious', -signatures;

sub create_invoice ( $self, $options ) {
  my $invoice;

  eval {
    $invoice = $self->create({ %$options });
  };

  return $@ ? 0 : $invoice;
}

# Get Invoice by id
sub get_invoice_by_id ( $self, $invoice_id ) {
  my $invoice = $self->search( { invoice_id => $invoice_id } );

  return $invoice;
}

# Get All Invoices
sub get_all_invoices ( $self ) {
  my $invoice = $self->search( {} );

  return $invoice;
}

# Get Filtered Invoices by their state Draft, Invoiced and Cancelled
sub get_filtered_state_invoices ( $self, $state ) {
  my @invoice = $self->search( { status_invoice => $state } );

  return \@invoice;
}

# Get Filtered Invoices by Payment state
# 'unpaid','paid','partly_paid','partly_paid_and_credit_note','credit_note','overpaid'
sub get_filtered_payment_state_invoices ( $self, $state ) {
  my @invoice = $self->search( { status_payment => $state } );

  return \@invoice;
}

1;