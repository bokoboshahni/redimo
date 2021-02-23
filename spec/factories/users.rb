# frozen_string_literal: true

# ## Schema Information
#
# Table name: `users`
#
# ### Columns
#
# Name                            | Type               | Attributes
# ------------------------------- | ------------------ | ---------------------------
# **`id`**                        | `text`             | `not null, primary key`
# **`eve_character_name`**        | `text`             |
# **`eve_character_owner_hash`**  | `text`             |
# **`uuid`**                      | `uuid`             | `not null`
# **`created_at`**                | `datetime`         | `not null`
# **`updated_at`**                | `datetime`         | `not null`
# **`eve_character_id`**          | `text`             |
#
# ### Indexes
#
# * `index_users_on_eve_character_id` (_unique_):
#     * **`eve_character_id`**
# * `index_users_on_eve_character_name` (_unique_):
#     * **`eve_character_name`**
# * `index_users_on_eve_character_owner_hash`:
#     * **`eve_character_owner_hash`**
# * `index_users_on_uuid` (_unique_):
#     * **`uuid`**
#
FactoryBot.define do
  factory :user do
  end
end
