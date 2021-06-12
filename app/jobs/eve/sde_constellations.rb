# frozen_string_literal: true

module EVE
  # Loads EVE constellation data from the EVE static data export.
  module SDEConstellationsJob
    module_function

    def setup(sde_dir: Rails.root.join('db/sde'))
      Kiba.parse do
        source EVE::SDEConstellationsSource, sde_dir: sde_dir
        transform EVE::SDEConstellationAttributesTransform
        destination EVE::ConstellationDestination
      end
    end
  end
end
