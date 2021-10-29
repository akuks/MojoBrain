use utf8;
package MojoBrain::Schema::Result::User;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MojoBrain::Schema::Result::User

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

=head1 TABLE: C<users>

=cut

__PACKAGE__->table("users");

=head1 ACCESSORS

=head2 user_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 191

=head2 slug

  data_type: 'varchar'
  is_nullable: 0
  size: 191

=head2 password

  data_type: 'varchar'
  is_nullable: 0
  size: 60

=head2 email

  data_type: 'varchar'
  is_nullable: 0
  size: 191

=head2 profile_image

  data_type: 'varchar'
  is_nullable: 1
  size: 2000

=head2 cover_image

  data_type: 'varchar'
  is_nullable: 1
  size: 2000

=head2 user_bio

  data_type: 'text'
  is_nullable: 1

=head2 website

  data_type: 'text'
  is_nullable: 1

=head2 facebook

  data_type: 'text'
  is_nullable: 1

=head2 twitter

  data_type: 'text'
  is_nullable: 1

=head2 linkedin

  data_type: 'text'
  is_nullable: 1

=head2 dev_to

  data_type: 'text'
  is_nullable: 1

=head2 accessibility

  data_type: 'text'
  is_nullable: 1

=head2 status

  data_type: 'varchar'
  default_value: 'active'
  is_nullable: 0
  size: 50

=head2 visibility

  data_type: 'varchar'
  default_value: 'public'
  is_nullable: 0
  size: 50

=head2 meta_title

  data_type: 'varchar'
  is_nullable: 1
  size: 2000

=head2 meta_description

  data_type: 'varchar'
  is_nullable: 1
  size: 2000

=head2 tour

  data_type: 'text'
  is_nullable: 1

=head2 last_seen

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 created_at

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  default_value: 'CURRENT_TIMESTAMP'
  is_nullable: 0

=head2 created_by

  data_type: 'varchar'
  is_nullable: 0
  size: 24

=head2 updated_at

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 updated_by

  data_type: 'varchar'
  is_nullable: 1
  size: 24

=cut

__PACKAGE__->add_columns(
  "user_id",
  { data_type => "bigint", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 191 },
  "slug",
  { data_type => "varchar", is_nullable => 0, size => 191 },
  "password",
  { data_type => "varchar", is_nullable => 0, size => 60 },
  "email",
  { data_type => "varchar", is_nullable => 0, size => 191 },
  "profile_image",
  { data_type => "varchar", is_nullable => 1, size => 2000 },
  "cover_image",
  { data_type => "varchar", is_nullable => 1, size => 2000 },
  "user_bio",
  { data_type => "text", is_nullable => 1 },
  "website",
  { data_type => "text", is_nullable => 1 },
  "facebook",
  { data_type => "text", is_nullable => 1 },
  "twitter",
  { data_type => "text", is_nullable => 1 },
  "linkedin",
  { data_type => "text", is_nullable => 1 },
  "dev_to",
  { data_type => "text", is_nullable => 1 },
  "accessibility",
  { data_type => "text", is_nullable => 1 },
  "status",
  {
    data_type => "varchar",
    default_value => "active",
    is_nullable => 0,
    size => 50,
  },
  "visibility",
  {
    data_type => "varchar",
    default_value => "public",
    is_nullable => 0,
    size => 50,
  },
  "meta_title",
  { data_type => "varchar", is_nullable => 1, size => 2000 },
  "meta_description",
  { data_type => "varchar", is_nullable => 1, size => 2000 },
  "tour",
  { data_type => "text", is_nullable => 1 },
  "last_seen",
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
  "created_by",
  { data_type => "varchar", is_nullable => 0, size => 24 },
  "updated_at",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  "updated_by",
  { data_type => "varchar", is_nullable => 1, size => 24 },
);

=head1 PRIMARY KEY

=over 4

=item * L</user_id>

=back

=cut

__PACKAGE__->set_primary_key("user_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<users_email_unique>

=over 4

=item * L</email>

=back

=cut

__PACKAGE__->add_unique_constraint("users_email_unique", ["email"]);

=head2 C<users_slug_unique>

=over 4

=item * L</slug>

=back

=cut

__PACKAGE__->add_unique_constraint("users_slug_unique", ["slug"]);

=head1 RELATIONS

=head2 clients

Type: has_many

Related object: L<MojoBrain::Schema::Result::Client>

=cut

__PACKAGE__->has_many(
  "clients",
  "MojoBrain::Schema::Result::Client",
  { "foreign.user_id" => "self.user_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 company_setting

Type: might_have

Related object: L<MojoBrain::Schema::Result::CompanySetting>

=cut

__PACKAGE__->might_have(
  "company_setting",
  "MojoBrain::Schema::Result::CompanySetting",
  { "foreign.user_id" => "self.user_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2021-10-29 23:22:35
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:iJXIT0PUFxE7+8YNIa8v7w


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
