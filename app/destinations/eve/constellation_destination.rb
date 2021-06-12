# frozen_string_literal: true

module EVE
  class ConstellationDestination < SingleRowDestination
    self.model_class = EVE::Constellation
  end
end
