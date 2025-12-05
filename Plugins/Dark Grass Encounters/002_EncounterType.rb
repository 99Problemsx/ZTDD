#===============================================================================
# Dark Grass Encounter Type
# Defines the encounter type for dark grass tiles
#===============================================================================

# Register the Dark Grass encounter type
GameData::EncounterType.register({
  :id             => :DarkGrass,
  :type           => :darkgrass,
  :trigger_chance => 21
})

# You can optionally add time-based variants (Morning, Day, Night, etc.)
# These would use the same :darkgrass type but different IDs for time filtering

GameData::EncounterType.register({
  :id             => :DarkGrassDay,
  :type           => :darkgrass,
  :trigger_chance => 21
})

GameData::EncounterType.register({
  :id             => :DarkGrassNight,
  :type           => :darkgrass,
  :trigger_chance => 21
})

GameData::EncounterType.register({
  :id             => :DarkGrassMorning,
  :type           => :darkgrass,
  :trigger_chance => 21
})

GameData::EncounterType.register({
  :id             => :DarkGrassAfternoon,
  :type           => :darkgrass,
  :trigger_chance => 21
})

GameData::EncounterType.register({
  :id             => :DarkGrassEvening,
  :type           => :darkgrass,
  :trigger_chance => 21
})

#===============================================================================
# Modify PokemonEncounters to support Dark Grass
#===============================================================================

class PokemonEncounters
  # Add dark grass to the has_land_encounters? check
  # This allows dark grass encounters to trigger when walking
  alias darkgrass_has_land_encounters? has_land_encounters?
  
  def has_land_encounters?
    # Check for normal land encounters first
    return true if darkgrass_has_land_encounters?
    # Check for dark grass encounters
    GameData::EncounterType.each do |enc_type|
      return true if enc_type.type == :darkgrass && has_encounter_type?(enc_type.id)
    end
    return false
  end
  
  # Modify encounter_possible_here? to include dark grass terrain
  alias darkgrass_encounter_possible_here? encounter_possible_here?
  
  def encounter_possible_here?
    # Check original conditions first
    return true if darkgrass_encounter_possible_here?
    # Check if on dark grass tile
    terrain_tag = $game_map.terrain_tag($game_player.x, $game_player.y)
    return true if has_land_encounters? && terrain_tag.dgrass_wild_encounters
    return false
  end
  
  # Modify encounter_type to return dark grass encounter type when on dark grass
  alias darkgrass_encounter_type encounter_type
  
  def encounter_type
    time = pbGetTimeNow
    ret = nil
    terrain_tag = $game_map.terrain_tag($game_player.x, $game_player.y)
    
    # Check if player is on dark grass tile
    if !$PokemonGlobal.surfing && has_land_encounters? && terrain_tag.dgrass_wild_encounters
      # Try to find time-specific dark grass encounter
      ret = find_valid_encounter_type_for_time(:DarkGrass, time)
      return ret if ret
    end
    
    # Fall back to original encounter type logic
    return darkgrass_encounter_type
  end
end
