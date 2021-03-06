# frozen_string_literal: true

# ## Schema Information
#
# Table name: `users`
#
# ### Columns
#
# Name                                | Type               | Attributes
# ----------------------------------- | ------------------ | ---------------------------
# **`id`**                            | `text`             | `not null, primary key`
# **`admin`**                         | `boolean`          | `default(FALSE)`
# **`associate`**                     | `boolean`          | `default(FALSE)`
# **`esi_access_token_ciphertext`**   | `text`             |
# **`esi_expires_at`**                | `datetime`         |
# **`esi_refresh_token_ciphertext`**  | `text`             |
# **`eve_character_name`**            | `text`             |
# **`eve_character_owner_hash`**      | `text`             |
# **`uuid`**                          | `uuid`             | `not null`
# **`created_at`**                    | `datetime`         | `not null`
# **`updated_at`**                    | `datetime`         | `not null`
# **`eve_alliance_id`**               | `integer`          |
# **`eve_character_id`**              | `text`             |
# **`eve_corporation_id`**            | `integer`          |
#
# ### Indexes
#
# * `index_users_on_eve_alliance_id`:
#     * **`eve_alliance_id`**
# * `index_users_on_eve_character_id` (_unique_):
#     * **`eve_character_id`**
# * `index_users_on_eve_character_name` (_unique_):
#     * **`eve_character_name`**
# * `index_users_on_eve_character_owner_hash`:
#     * **`eve_character_owner_hash`**
# * `index_users_on_eve_corporation_id`:
#     * **`eve_corporation_id`**
# * `index_users_on_uuid` (_unique_):
#     * **`uuid`**
#
FactoryBot.define do
  factory :users do
  end
end
