# frozen_string_literal: true

module EVE
  class SDEConstellationsSource
    attr_reader :sde_dir

    def initialize(sde_dir:)
      @sde_dir = sde_dir
    end

    def each
      constellation_files = Dir[File.join(sde_dir, 'fsd/universe/**/constellation.staticdata')]
      constellation_files.each do |file|
        data = YAML.load_file(file)
      end
    end

    private

    def names
      @names ||= begin
        data = YAML.load_file(File.join(sde_dir, 'bsd/invNames.yaml'))
        data.each_with_object({}) { |i, h| h[i['itemID'] = i['itemName']] }
      end
    end

    def regions
      @regions ||= begin
      end
    end
  end
end
