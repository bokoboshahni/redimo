# frozen_string_literal: true

# Retrives character information from ESI.
class GetCharacter
  include ESIHelpers

  attr_reader :character_id

  def initialize(character_id)
    @character_id = character_id
  end

  def call
    esi_get("/latest/characters/#{character_id}")
  end
end
