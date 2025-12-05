#-------------------------------------------------------------------------------
# Aliased Surf call to not shown Following Pokemon Field move animation
# when surfing
#-------------------------------------------------------------------------------
alias __followingpkmn__pbSurf pbSurf unless defined?(__followingpkmn__pbSurf)
def pbSurf(*args)
  $game_temp.no_follower_field_move = true
  old_surfing = $PokemonGlobal.current_surfing
  pkmn = $player.get_pokemon_with_move(:SURF)
  $PokemonGlobal.current_surfing = pkmn
  ret = __followingpkmn__pbSurf(*args)
  $PokemonGlobal.current_surfing = old_surfing if !ret || !pkmn
  $game_temp.no_follower_field_move = false
  return ret
end

#-------------------------------------------------------------------------------
# Aliased surf starting method to refresh Following Pokemon when the player
# jumps to surf AND properly load swimming sprites
#-------------------------------------------------------------------------------
alias __followingpkmn__pbStartSurfing pbStartSurfing unless defined?(__followingpkmn__pbStartSurfing)
def pbStartSurfing(*args)
  old_toggled = $PokemonGlobal.follower_toggled
  surf_anim_1 = FollowingPkmn.active?
  $PokemonGlobal.surfing = true
  FollowingPkmn.refresh_internal
  surf_anim_2 = FollowingPkmn.active?
  $PokemonGlobal.surfing = false
  FollowingPkmn.toggle_off(true) if surf_anim_1 != surf_anim_2
  
  ret = __followingpkmn__pbStartSurfing(*args)
  
  FollowingPkmn.toggle(old_toggled, false)
  
  # Lade Surf-Sprite für Following Pokemon wenn vorhanden
  if FollowingPkmn.active? && $PokemonGlobal.surfing
    event = FollowingPkmn.get_event
    pkmn = FollowingPkmn.get_pokemon
    
    if event && pkmn
      # Versuche Surf-Sprite zu laden
      species_data = GameData::Species.get(pkmn.species)
      form = pkmn.form || 0
      
      # Check für Shiny Surf-Sprites zuerst
      surf_sprite = nil
      if pkmn.shiny?
        if pbResolveBitmap(sprintf("Graphics/Characters/Followers/%s_%d_shiny_surf", species_data.id, form))
          surf_sprite = sprintf("Followers/%s_%d_shiny_surf", species_data.id, form)
        elsif pbResolveBitmap(sprintf("Graphics/Characters/Followers/%s_shiny_surf", species_data.id))
          surf_sprite = sprintf("Followers/%s_shiny_surf", species_data.id)
        end
      end
      
      # Normale Surf-Sprites wenn kein Shiny gefunden
      if !surf_sprite
        if pbResolveBitmap(sprintf("Graphics/Characters/Followers/%s_%d_surf", species_data.id, form))
          surf_sprite = sprintf("Followers/%s_%d_surf", species_data.id, form)
        elsif pbResolveBitmap(sprintf("Graphics/Characters/Followers/%s_surf", species_data.id))
          surf_sprite = sprintf("Followers/%s_surf", species_data.id)
        end
      end
      
      if surf_sprite
        # Verwende Surf-Sprite
        event.character_name = surf_sprite
        event.transparent = false
        event.through = false
      else
        # Kein Surf-Sprite verfügbar - verstecke Pokemon
        event.transparent = true
      end
      
      # Fix Bush depth für Wasser
      event.calculate_bush_depth
    end
  end
  
  # Refresh sprite to use swimming sprites if available
  FollowingPkmn.refresh(false) if FollowingPkmn.active?
  
  return ret
end

#-------------------------------------------------------------------------------
# Aliased surf ending method to queue a refresh after the player jumps to stop
# surfing AND restore normal sprites
#-------------------------------------------------------------------------------
alias __followingpkmn__pbEndSurf pbEndSurf unless defined?(__followingpkmn__pbEndSurf)
def pbEndSurf(*args)
  surf_anim_1 = FollowingPkmn.active?
  ret = __followingpkmn__pbEndSurf(*args)
  return false if !ret
  
  $PokemonGlobal.current_surfing = nil
  FollowingPkmn.refresh_internal
  surf_anim_2 = FollowingPkmn.active?
  $PokemonGlobal.call_refresh = [true, (surf_anim_1 != surf_anim_2), 1]
  
  # Stelle normale Sprites wieder her
  if FollowingPkmn.active? && !$PokemonGlobal.surfing
    event = FollowingPkmn.get_event
    pkmn = FollowingPkmn.get_pokemon
    
    if event && pkmn
      # Lade normales Sprite
      species_data = GameData::Species.get(pkmn.species)
      form = pkmn.form || 0
      
      # Setze normales Following Sprite (mit Shiny-Check)
      normal_sprite = nil
      if pkmn.shiny?
        if pbResolveBitmap(sprintf("Graphics/Characters/Followers/%s_%d_shiny", species_data.id, form))
          normal_sprite = sprintf("Followers/%s_%d_shiny", species_data.id, form)
        elsif pbResolveBitmap(sprintf("Graphics/Characters/Followers/%s_shiny", species_data.id))
          normal_sprite = sprintf("Followers/%s_shiny", species_data.id)
        end
      end
      
      # Fallback zu normalem Sprite
      if !normal_sprite
        if pbResolveBitmap(sprintf("Graphics/Characters/Followers/%s_%d", species_data.id, form))
          normal_sprite = sprintf("Followers/%s_%d", species_data.id, form)
        else
          normal_sprite = sprintf("Followers/%s", species_data.id)
        end
      end
      
      event.character_name = normal_sprite
      event.transparent = false
      event.through = false
      event.calculate_bush_depth
    end
  end
  
  FollowingPkmn.refresh(false) if FollowingPkmn.active?
  
  return ret
end

#-------------------------------------------------------------------------------
# Aliased Diving method to not show new HM Animation when diving
#-------------------------------------------------------------------------------
alias __followingpkmn__pbDive pbDive unless defined?(__followingpkmn__pbDive)
def pbDive(*args)
  $game_temp.no_follower_field_move = true
  old_diving = $PokemonGlobal.current_diving
  pkmn = $player.get_pokemon_with_move(:DIVE)
  $PokemonGlobal.current_diving = pkmn
  ret = __followingpkmn__pbDive(*args)
  $PokemonGlobal.current_diving = old_diving if !ret || !pkmn
  $game_temp.no_follower_field_move = false
  # Fix dive animation immediately by recalculating bush depth
  FollowingPkmn.get_event&.calculate_bush_depth if ret
  return ret
end

#-------------------------------------------------------------------------------
# Aliased surfacing method to not show new HM Animation when surfacing
#-------------------------------------------------------------------------------
alias __followingpkmn__pbSurfacing pbSurfacing unless defined?(__followingpkmn__pbSurfacing)
def pbSurfacing(*args)
  $game_temp.no_follower_field_move = true
  old_diving = $PokemonGlobal.current_diving
  $PokemonGlobal.current_diving = nil
  ret = __followingpkmn__pbSurfacing(*args)
  $PokemonGlobal.current_diving = old_diving if !ret
  $game_temp.no_follower_field_move = false
  # Fix surfacing animation immediately by recalculating bush depth
  FollowingPkmn.get_event&.calculate_bush_depth if ret
  return ret
end

#-------------------------------------------------------------------------------
# Aliased hidden move usage method to not show new HM animation for certain
# moves
#-------------------------------------------------------------------------------
alias __followingpkmn__pbUseHiddenMove pbUseHiddenMove unless defined?(__followingpkmn__pbUseHiddenMove)
def pbUseHiddenMove(pokemon, move)
  $game_temp.no_follower_field_move = [:SURF, :DIVE, :FLY, :DIG, :TELEPORT, :WATERFALL, :STRENGTH].include?(move)
  if move == :SURF
    old_data = $PokemonGlobal.current_surfing
    $PokemonGlobal.current_surfing = pokemon
  elsif move == :DIVE
    old_data = $PokemonGlobal.current_diving
    $PokemonGlobal.current_diving = pokemon
  end
  ret = __followingpkmn__pbUseHiddenMove(pokemon, move)
  if move == :SURF
    $PokemonGlobal.current_surfing = old_data if !ret
  elsif move == :DIVE
    $PokemonGlobal.current_diving = old_data if !ret
  end
  $game_temp.no_follower_field_move = false
  return ret
end

#-------------------------------------------------------------------------------
# Aliased Headbutt method to properly load Headbutt event for new HM Animation
#-------------------------------------------------------------------------------
alias __followingpkmn__pbHeadbutt pbHeadbutt unless defined?(__followingpkmn__pbHeadbutt)
def pbHeadbutt(*args)
  args[0] = $game_player.pbFacingEvent(true) if args[0].nil?
  return __followingpkmn__pbHeadbutt(*args)
end

#-------------------------------------------------------------------------------
# Aliased Waterfall method to not show new HM Animation when interacting with
# waterfall
#-------------------------------------------------------------------------------
alias __followingpkmn__pbWaterfall pbWaterfall unless defined?(__followingpkmn__pbWaterfall)
def pbWaterfall(*args)
  $game_temp.no_follower_field_move = true
  $player.get_pokemon_with_move(:WATERFALL)
  ret = __followingpkmn__pbWaterfall(*args)
  $game_temp.no_follower_field_move = false
  return ret
end

#-------------------------------------------------------------------------------
# Aliased waterfall ascending method to make sure Following Pokemon properly
# ascends the Waterfall with the player
#-------------------------------------------------------------------------------
def pbAscendWaterfall
  return if $game_player.direction != 8   # Can't ascend if not facing up
  terrain = $game_player.pbFacingTerrainTag
  return if !terrain.waterfall && !terrain.waterfall_crest
  $stats.waterfall_count += 1
  oldthrough   = $game_player.through
  oldmovespeed = $game_player.move_speed
  $game_player.through    = true
  $game_player.move_speed = 2
  loop do
    $game_player.move_up
    terrain = $game_player.pbTerrainTag
    break if !terrain.waterfall && !terrain.waterfall_crest
    while $game_player.moving?
      Graphics.update
      Input.update
      pbUpdateSceneMap
    end
  end
  $game_player.through    = oldthrough
  $game_player.move_speed = oldmovespeed
end

#-------------------------------------------------------------------------------
# Aliased waterfall descending method to make sure Following Pokemon properly
# descends the Waterfall with the player
#-------------------------------------------------------------------------------
def pbDescendWaterfall
  return if $game_player.direction != 2   # Can't descend if not facing down
  terrain = $game_player.pbFacingTerrainTag
  return if !terrain.waterfall && !terrain.waterfall_crest
  $stats.waterfalls_descended += 1
  oldthrough   = $game_player.through
  oldmovespeed = $game_player.move_speed
  $game_player.through    = true
  $game_player.move_speed = 2
  loop do
    $game_player.move_down
    terrain = $game_player.pbTerrainTag
    break if !terrain.waterfall && !terrain.waterfall_crest
    while $game_player.moving?
      Graphics.update
      Input.update
      pbUpdateSceneMap
    end
  end
  $game_player.through    = oldthrough
  $game_player.move_speed = oldmovespeed
end

#-------------------------------------------------------------------------------
# Event handler for immediate sprite updates when action button is pressed
# DISABLED: Events.onAction does not exist in Pokemon Essentials v21
# This functionality is already handled in pbStartSurfing method above
#-------------------------------------------------------------------------------
# Events.onAction += proc { |_sender, _e|
#   next if !FollowingPkmn.active?
#   
#   # Sofortige Sprite-Aktualisierung beim Surfen
#   if $PokemonGlobal.surfing
#     event = FollowingPkmn.get_event
#     next if !event
#     
#     pkmn = FollowingPkmn.get_pokemon
#     if pkmn
#       species_data = GameData::Species.get(pkmn.species)
#       form = pkmn.form || 0
#       
#       # Versuche Surf-Sprite zu laden (mit Shiny-Check)
#       surf_sprite = nil
#       if pkmn.shiny?
#         paths = [
#           sprintf("Graphics/Characters/Followers/%s_%d_shiny_surf", species_data.id, form),
#           sprintf("Graphics/Characters/Followers/%s_shiny_surf", species_data.id)
#         ]
#         paths.each do |path|
#           if pbResolveBitmap(path)
#             surf_sprite = path.sub("Graphics/Characters/", "")
#             break
#           end
#         end
#       end
#       
#       # Normale Surf-Sprites wenn kein Shiny
#       if !surf_sprite
#         paths = [
#           sprintf("Graphics/Characters/Followers/%s_%d_surf", species_data.id, form),
#           sprintf("Graphics/Characters/Followers/%s_surf", species_data.id)
#         ]
#         paths.each do |path|
#           if pbResolveBitmap(path)
#             surf_sprite = path.sub("Graphics/Characters/", "")
#             break
#           end
#         end
#       end
#       
#       if surf_sprite
#         event.character_name = surf_sprite
#         event.transparent = false
#       else
#         event.transparent = true
#       end
#     end
#   end
# }
