# frozen_string_literal: true

# Abstract class for application models.
class ApplicationRecord < ActiveRecord::Base
  include IDGeneration

  self.abstract_class = true
end
