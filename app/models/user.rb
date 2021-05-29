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
class User < ApplicationRecord
  include UUIDGeneration

  devise :omniauthable, :timeoutable

  encrypts :esi_access_token, :esi_refresh_token

  def self.from_esi(auth)
    user = where(eve_character_id: auth.uid).first_or_create do |u|
      u.eve_character_name = auth.info.name
      u.eve_character_owner_hash = auth.info.character_owner_hash
    end

    user.credentials_from_sso
    user.character_info_from_esi
    user.save
    user
  end

  def character_info_from_esi
    character_info = GetCharacter.new(user.eve_character_id).call
    self.eve_alliance_id = character_info['alliance_id']
    self.eve_corporation_id = character_info['corporation_id']
  end

  def credentials_from_sso(auth)
    self.esi_access_token = auth.credentials.token
    self.esi_expires_at = Time.zone.at(auth.credentials.expires_at).to_datetime
    self.esi_refresh_token = auth.credentials.refresh_token
  end
end
