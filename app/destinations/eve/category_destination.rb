# frozen_string_literal: true

module EVE
  class CategoryDestination < SingleRowDestination
    self.model_class = EVE::Constellation
  end
end
