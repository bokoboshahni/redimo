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
FactoryBot.define do
  factory :eve_category, class: 'EVE::Category' do
  end
end
