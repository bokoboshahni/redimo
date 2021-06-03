# frozen_string_literal: true

# ## Schema Information
#
# Table name: `eve_types`
#
# ### Columns
#
# Name                    | Type               | Attributes
# ----------------------- | ------------------ | ---------------------------
# **`id`**                | `uuid`             | `not null, primary key`
# **`capacity`**          | `decimal(, )`      |
# **`description`**       | `text`             |
# **`dogma_attributes`**  | `jsonb`            |
# **`dogma_effects`**     | `jsonb`            |
# **`mass`**              | `decimal(, )`      |
# **`name`**              | `text`             |
# **`packaged_volume`**   | `decimal(, )`      |
# **`portion_size`**      | `integer`          |
# **`published`**         | `boolean`          |
# **`radius`**            | `decimal(, )`      |
# **`volume`**            | `decimal(, )`      |
# **`created_at`**        | `datetime`         | `not null`
# **`updated_at`**        | `datetime`         | `not null`
# **`graphic_id`**        | `integer`          |
# **`group_id`**          | `integer`          |
# **`icon_id`**           | `integer`          |
# **`market_group_id`**   | `integer`          |
# **`type_id`**           | `integer`          |
#
# ### Indexes
#
# * `index_eve_types_on_type_id` (_unique_):
#     * **`type_id`**
#
require 'rails_helper'

RSpec.describe EVEType, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
