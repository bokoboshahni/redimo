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
class User < ApplicationRecord
  include UUIDGeneration

  devise :omniauthable, :timeoutable

  def self.from_esi(auth)
    where(eve_character_id: auth.uid).first_or_create do |user|
      user.eve_character_name = auth.info.name
      user.eve_character_owner_hash = auth.info.character_owner_hash
    end
  end
end
