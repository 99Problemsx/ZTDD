#===============================================================================
# Dark Grass Battle BGM
# Allows custom battle music for dark grass encounters
#===============================================================================

# Override pbGetWildBattleBGM to check for dark grass terrain
alias darkgrass_pbGetWildBattleBGM pbGetWildBattleBGM

def pbGetWildBattleBGM(_wildParty)
  return $PokemonGlobal.nextBattleBGM.clone if $PokemonGlobal.nextBattleBGM
  ret = nil
  
  # Check if player is on dark grass terrain
  if $game_map && $game_player
    terrain_tag = GameData::TerrainTag.try_get($game_player.terrain_tag)
    if terrain_tag && terrain_tag.dgrass_wild_encounters
      # Try to get dark grass specific BGM from map metadata
      music = $game_map.metadata&.dark_grass_battle_BGM
      ret = pbStringToAudioFile(music) if music && music != ""
      
      # If no map-specific BGM, you can set a default dark grass BGM here
      # Uncomment and replace with your BGM filename:
      # ret = pbStringToAudioFile("Battle dark grass") if !ret
    end
  end
  
  # Fall back to original method if no dark grass BGM found
  return darkgrass_pbGetWildBattleBGM(_wildParty) if !ret
  return ret
end
