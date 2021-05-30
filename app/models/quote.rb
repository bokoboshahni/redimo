# frozen_string_literal: true

# ## Schema Information
#
# Table name: `quotes`
#
# ### Columns
#
# Name                  | Type               | Attributes
# --------------------- | ------------------ | ---------------------------
# **`id`**              | `text`             | `not null, primary key`
# **`appraisal_data`**  | `jsonb`            |
# **`appraisal_type`**  | `text`             |
# **`appraisal_url`**   | `text`             |
# **`expires_at`**      | `datetime`         |
# **`number`**          | `integer`          | `not null`
# **`price_data`**      | `jsonb`            |
# **`type`**            | `text`             |
# **`uuid`**            | `uuid`             | `not null`
# **`created_at`**      | `datetime`         | `not null`
# **`updated_at`**      | `datetime`         | `not null`
# **`appraisal_id`**    | `text`             |
#
# ### Indexes
#
# * `index_quotes_on_appraisal_data` (_using_ gin):
#     * **`appraisal_data`**
# * `index_quotes_on_appraisal_id`:
#     * **`appraisal_id`**
# * `index_quotes_on_appraisal_type`:
#     * **`appraisal_type`**
# * `index_quotes_on_expires_at`:
#     * **`expires_at`**
# * `index_quotes_on_number` (_unique_):
#     * **`number`**
# * `index_quotes_on_type`:
#     * **`type`**
# * `index_quotes_on_uuid` (_unique_):
#     * **`uuid`**
#
class Quote < ApplicationRecord
  include UUIDGeneration

  self.inheritance_column = nil

  APPRAISAL_URL_FORMAT = %r{\Ahttps://(evepraisal|janice\.e-351)\.com/a/([a-zA-Z0-9]{1,13})(/[a-zA-Z0-9]{1,13})?\z}

  VALID_FOR = 3.days

  attr_accessor :raw_appraisal

  validates :type, inclusion: { in: %w[hauling procurement reprocessing], allow_blank: true }

  def items
    appraisal_data['items']
  end

  def packaged_volume
    appraisal_data['total_packaged_volume']
  end

  def total_buy
    appraisal_data['total_buy']
  end

  def total_sell
    appraisal_data['total_sell']
  end

  def volume
    appraisal_data['total_volume']
  end
end
