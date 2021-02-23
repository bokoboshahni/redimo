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
class Quote < ApplicationRecord
  include UUIDGeneration

  EVEPRAISAL_URL_FORMAT = %r{\Ahttps://evepraisal\.com/a/([a-zA-Z0-9]{1,13})(/[a-zA-Z0-9]{1,13})?\z}.freeze

  attr_accessor :evepraisal_url

  validates :evepraisal_url, presence: true, url: { allow_blank: true, schemes: 'https' },
                             format: { with: EVEPRAISAL_URL_FORMAT }

  def items
    evepraisal_data['items']
  end

  def sell
    evepraisal_data['totals']['sell']
  end

  def volume
    evepraisal_data['totals']['volume']
  end

  def collateral
    sell * 1.1
  end
end
