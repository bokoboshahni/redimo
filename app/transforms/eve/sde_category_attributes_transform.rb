# frozen_string_literal: true

module EVE
  class SDECategoryAttributesTransform
    ATTRIBUTES = %(id name published)

    def process(row)
      row['name'] = row['name']['en']
      row.select { |(k, _)| ATTRIBUTES.include?(k) }
    end
  end
end
