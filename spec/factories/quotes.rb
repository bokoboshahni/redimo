# frozen_string_literal: true

# ## Schema Information
#
# Table name: `quotes`
#
# ### Columns
#
# Name                   | Type               | Attributes
# ---------------------- | ------------------ | ---------------------------
# **`id`**               | `text`             | `not null, primary key`
# **`evepraisal_data`**  | `jsonb`            |
# **`expires_at`**       | `datetime`         |
# **`number`**           | `integer`          | `not null`
# **`price`**            | `jsonb`            |
# **`uuid`**             | `uuid`             | `not null`
# **`created_at`**       | `datetime`         | `not null`
# **`updated_at`**       | `datetime`         | `not null`
# **`evepraisal_id`**    | `text`             |
#
# ### Indexes
#
# * `index_quotes_on_evepraisal_data` (_using_ gin):
#     * **`evepraisal_data`**
# * `index_quotes_on_evepraisal_id` (_unique_):
#     * **`evepraisal_id`**
# * `index_quotes_on_expires_at`:
#     * **`expires_at`**
# * `index_quotes_on_number` (_unique_):
#     * **`number`**
# * `index_quotes_on_price` (_using_ gin):
#     * **`price`**
# * `index_quotes_on_uuid` (_unique_):
#     * **`uuid`**
#
FactoryBot.define do
  factory :quote do
  end
end
