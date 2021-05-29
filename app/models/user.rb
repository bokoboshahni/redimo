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
# **`eve_character_id`**              | `text`             |
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

  encrypts :esi_access_token, :esi_refresh_token

  def self.from_esi(auth) # rubocop:disable Metrics/AbcSize
    user = where(eve_character_id: auth.uid).first_or_create do |u|
      u.eve_character_name = auth.info.name
      u.eve_character_owner_hash = auth.info.character_owner_hash
    end

    user.esi_access_token = auth.credentials.token
    user.esi_expires_at = Time.zone.at(auth.credentials.expires_at).to_datetime
    user.esi_refresh_token = auth.credentials.refresh_token
    user.save
    user
  end
end
