# frozen_string_literal: true

module EVE
  # Loads EVE category data from the EVE static data export.
  module SDECategoriesJob
    module_function

    def setup(sde_dir: Rails.root.join('db/sde'))
      Kiba.parse do
        source EVE::SDECategoriesSource, sde_dir: sde_dir
        transform EVE::SDECategoryAttributesTransform
        destination EVE::CategoryDestination
      end
    end
  end
end
