# frozen_string_literal: true

# ## Schema Information
#
# Table name: `eve_static_data_exports`
#
# ### Columns
#
# Name                             | Type               | Attributes
# -------------------------------- | ------------------ | ---------------------------
# **`id`**                         | `text`             | `not null, primary key`
# **`checksum`**                   | `text`             | `not null`
# **`sde_archive_checksum_data`**  | `jsonb`            |
# **`sde_archive_data`**           | `jsonb`            |
# **`sde_archive_sha512_data`**    | `jsonb`            |
# **`status`**                     | `text`             | `not null`
# **`status_text`**                | `text`             |
# **`uploaded_at`**                | `datetime`         |
# **`uuid`**                       | `uuid`             | `not null`
# **`created_at`**                 | `datetime`         | `not null`
# **`updated_at`**                 | `datetime`         | `not null`
#
# ### Indexes
#
# * `index_eve_static_data_exports_on_checksum` (_unique_):
#     * **`checksum`**
# * `index_eve_static_data_exports_on_status`:
#     * **`status`**
# * `index_eve_static_data_exports_on_uuid` (_unique_):
#     * **`uuid`**
#
FactoryBot.define do
  factory :eve_static_data_export, class: 'EVE::StaticDataExport' do
  end
end
