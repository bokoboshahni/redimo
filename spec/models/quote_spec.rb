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
require 'rails_helper'

RSpec.describe Quote, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
