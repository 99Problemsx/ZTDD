# Map lighting definitions
PURPLE_HOUSE_MAP_ID = 43
PURPLE_HOUSE_BASE_X = 9
PURPLE_HOUSE_BASE_Y = 18

def add_window_light(id, x_offset, y_offset)
  GameData::LightEffect.add({
    id: id,
    type: :rect,
    width: 1,
    height: 1,
    map_x: PURPLE_HOUSE_BASE_X + x_offset,
    map_y: PURPLE_HOUSE_BASE_Y + y_offset,
    map_id: PURPLE_HOUSE_MAP_ID,
    day: false,
    stop_anim: false
  })
end

add_window_light(:house_purple_window_top_left, 0, 0)
add_window_light(:house_purple_window_top_center_left, 1, 0)
add_window_light(:house_purple_window_top_center_right, 2, 0)
add_window_light(:house_purple_window_top_right, 3, 0)
add_window_light(:house_purple_window_mid_left, 0, 1)
add_window_light(:house_purple_window_mid_center_left, 1, 1)
add_window_light(:house_purple_window_mid_center_right, 2, 1)
add_window_light(:house_purple_window_mid_right, 3, 1)
add_window_light(:house_purple_window_bot_left, 0, 2)
add_window_light(:house_purple_window_bot_center_left, 1, 2)
add_window_light(:house_purple_window_bot_center_right, 2, 2)
add_window_light(:house_purple_window_bot_right, 3, 2)

#===============================================================================
# Map 43 - Pokemon Center Lights
#===============================================================================

echoln("========================================")
echoln("LOADING POKEMON CENTER LIGHTS FOR MAP 43")
echoln("========================================")

# Pokemon Center window grid (037/019 to 042/024) - shifted up 1 tile
POKECENTER_MAP_ID = 43
POKECENTER_BASE_X = 37
POKECENTER_BASE_Y = 19

def add_pokecenter_light(id, x_offset, y_offset)
  GameData::LightEffect.add({
    id: id,
    type: :rect,
    width: 1,
    height: 1,
    map_x: POKECENTER_BASE_X + x_offset,
    map_y: POKECENTER_BASE_Y + y_offset,
    map_id: POKECENTER_MAP_ID,
    day: false,
    stop_anim: false
  })
end

# Row 1 (Y=20)
add_pokecenter_light(:pokecenter_0_0, 0, 0)
add_pokecenter_light(:pokecenter_1_0, 1, 0)
add_pokecenter_light(:pokecenter_2_0, 2, 0)
add_pokecenter_light(:pokecenter_3_0, 3, 0)
add_pokecenter_light(:pokecenter_4_0, 4, 0)
add_pokecenter_light(:pokecenter_5_0, 5, 0)

# Row 2 (Y=21)
add_pokecenter_light(:pokecenter_0_1, 0, 1)
add_pokecenter_light(:pokecenter_1_1, 1, 1)
add_pokecenter_light(:pokecenter_2_1, 2, 1)
add_pokecenter_light(:pokecenter_3_1, 3, 1)
add_pokecenter_light(:pokecenter_4_1, 4, 1)
add_pokecenter_light(:pokecenter_5_1, 5, 1)

# Row 3 (Y=22)
add_pokecenter_light(:pokecenter_0_2, 0, 2)
add_pokecenter_light(:pokecenter_1_2, 1, 2)
add_pokecenter_light(:pokecenter_2_2, 2, 2)
add_pokecenter_light(:pokecenter_3_2, 3, 2)
add_pokecenter_light(:pokecenter_4_2, 4, 2)
add_pokecenter_light(:pokecenter_5_2, 5, 2)

# Row 4 (Y=23)
add_pokecenter_light(:pokecenter_0_3, 0, 3)
add_pokecenter_light(:pokecenter_1_3, 1, 3)
add_pokecenter_light(:pokecenter_2_3, 2, 3)
add_pokecenter_light(:pokecenter_3_3, 3, 3)
add_pokecenter_light(:pokecenter_4_3, 4, 3)
add_pokecenter_light(:pokecenter_5_3, 5, 3)

# Row 5 (Y=24)
add_pokecenter_light(:pokecenter_0_4, 0, 4)
add_pokecenter_light(:pokecenter_1_4, 1, 4)
add_pokecenter_light(:pokecenter_2_4, 2, 4)
add_pokecenter_light(:pokecenter_3_4, 3, 4)
add_pokecenter_light(:pokecenter_4_4, 4, 4)
add_pokecenter_light(:pokecenter_5_4, 5, 4)

# Row 6 (Y=25)
add_pokecenter_light(:pokecenter_0_5, 0, 5)
add_pokecenter_light(:pokecenter_1_5, 1, 5)
add_pokecenter_light(:pokecenter_2_5, 2, 5)
add_pokecenter_light(:pokecenter_3_5, 3, 5)
add_pokecenter_light(:pokecenter_4_5, 4, 5)
add_pokecenter_light(:pokecenter_5_5, 5, 5)

echoln("Registered #{36} Pokemon Center window lights")

# Lamp circles (radius in pixels, not tiles!)
echoln("Registering Pokemon Center lamp circles...")

lamp_config = {
  type: :circle,
  radius: 64,
  map_id: 43,
  day: false,
  stop_anim: false
}

GameData::LightEffect.add(lamp_config.merge({
  id: :pokecenter_lamp_1,
  map_x: 34,
  map_y: 24
}))

GameData::LightEffect.add(lamp_config.merge({
  id: :pokecenter_lamp_2,
  map_x: 21,
  map_y: 33
}))

GameData::LightEffect.add(lamp_config.merge({
  id: :pokecenter_lamp_3,
  map_x: 34,
  map_y: 38
}))

GameData::LightEffect.add(lamp_config.merge({
  id: :pokecenter_lamp_4,
  map_x: 12,
  map_y: 22
}))

echoln("Total Pokemon Center lights registered: #{GameData::LightEffect::DATA.count { |k, v| v.map_id == 43 }}")

#===============================================================================
# Auto-refresh lighting when entering a map
#===============================================================================
EventHandlers.add(:on_enter_map, :refresh_custom_lights,
  proc {
    next if !$scene.is_a?(Scene_Map)
    
    # Beim Spielstart existieren die Spritesets noch nicht
    next if !$scene.instance_variable_defined?(:@spritesets) || !$scene.instance_variable_get(:@spritesets)
    
    spriteset = $scene.spriteset
    next if !spriteset  # spriteset kann nil sein
    
    # Try spritesetGlobal first (like debug menu)
    lighting = nil
    if $scene.respond_to?(:spritesetGlobal) && $scene.spritesetGlobal
      lighting = $scene.spritesetGlobal.lighting
    elsif spriteset.respond_to?(:lighting)
      lighting = spriteset.lighting
    end
    
    next if !lighting || lighting.disposed?
    
    echoln("Auto-refreshing lighting for map #{$game_map.map_id}")
    lighting.refresh_all(true)
  }
)


# Lamp circles
GameData::LightEffect.add({
  id: :pokecenter_lamp_1,
  type: :circle,
  radius: 5,
  map_x: 34,
  map_y: 24,
  map_id: 43,
  day: false,
  stop_anim: false
})

GameData::LightEffect.add({
  id: :pokecenter_lamp_2,
  type: :circle,
  radius: 5,
  map_x: 21,
  map_y: 33,
  map_id: 43,
  day: false,
  stop_anim: false
})

GameData::LightEffect.add({
  id: :pokecenter_lamp_3,
  type: :circle,
  radius: 5,
  map_x: 34,
  map_y: 38,
  map_id: 43,
  day: false,
  stop_anim: false
})

GameData::LightEffect.add({
  id: :pokecenter_lamp_4,
  type: :circle,
  radius: 5,
  map_x: 21,
  map_y: 33,
  map_id: 43,
  day: false,
  stop_anim: false
})

GameData::LightEffect.add({
  id: :pokecenter_lamp_5,
  type: :circle,
  radius: 5,
  map_x: 12,
  map_y: 22,
  map_id: 43,
  day: false,
  stop_anim: false
})
