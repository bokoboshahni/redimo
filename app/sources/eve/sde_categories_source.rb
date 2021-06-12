# frozen_string_literal: true

module EVE
  class SDECategoriesSource
    attr_reader :sde_dir

    def initialize(sde_dir:)
      @sde_dir = sde_dir
    end

    def each
      YAML.load_file(File.join(sde_dir, 'fsd/categoryIDs.yaml')).each do |id, category|
        yield category.merge('id' => id)
      end
    end
  end
end
