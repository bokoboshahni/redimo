# frozen_string_literal: true

module EVE
  class SingleRowDestination
    class_attribute :model_class

    def write(row)
      now = Time.zone.now
      if model_class.exists?(id: row['id'])
        attrs = row.reject { |(k, _)| k == 'id' }.merge(updated_at: now)
        model_class.update(row['id'], attrs)
      else
        attrs = row.merge(created_at: now, updated_at: now)
        model_class.insert(attrs)
      end
    end
  end
end
