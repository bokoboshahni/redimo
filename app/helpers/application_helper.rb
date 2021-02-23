# frozen_string_literal: true

# Application view helpers.
module ApplicationHelper
  def current_user_image_url(size = 512)
    eve_character_image_url(current_user.eve_character_id, size)
  end

  def eve_character_image_url(character_id, size = 512)
    "https://images.evetech.net/characters/#{character_id}/portrait?size=#{size}"
  end
end
