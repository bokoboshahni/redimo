# frozen_string_literal: true

# ## Schema Information
#
# Table name: `eve_categories`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`id`**          | `integer`          | `not null, primary key`
# **`name`**        | `text`             |
# **`published`**   | `boolean`          |
# **`created_at`**  | `datetime`         | `not null`
# **`updated_at`**  | `datetime`         | `not null`
#
require 'rails_helper'

RSpec.describe EVE::Category, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
