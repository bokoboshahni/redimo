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
# **`price`**            | `decimal(, )`      |
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
# * `index_quotes_on_uuid` (_unique_):
#     * **`uuid`**
#
require 'rails_helper'

RSpec.describe Quote, type: :model do
  describe 'quote factory' do
    it 'creates a quote', :vcr do
      expect(FactoryBot.create(:quote, evepraisal_url: 'https://evepraisal.com/a/yqfdq')).to be_persisted
    end
  end
end
