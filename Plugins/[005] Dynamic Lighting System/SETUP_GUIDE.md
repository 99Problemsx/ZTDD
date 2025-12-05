# Dynamic Lighting System - Setup Guide

## Table of Contents

1. [Overview](#overview)
2. [Map Types & Configuration](#map-types--configuration)
3. [Adding Light Sources](#adding-light-sources)
4. [Circle Lights (Lamps, Torches)](#circle-lights-lamps-torches)
5. [Rectangle Lights (Windows)](#rectangle-lights-windows)
6. [Custom Bitmap Lights](#custom-bitmap-lights)
7. [Day/Night Settings](#daynight-settings)
8. [Works on ALL Map Types](#works-on-all-map-types)
9. [Debug Tools](#debug-tools)
10. [Examples](#examples)

---

## Overview

The Dynamic Lighting System adds realistic lighting effects to your Pokémon Essentials game. It supports:

- **Circle lights** (lamps, torches, streetlights)
- **Rectangle lights** (windows, doors)
- **Custom bitmap lights** (shaped light sources)
- **Pulsating animations** (flickering effects)
- **Day/Night conditional lighting** (only show at night)
- **Event-attached lights** (follow characters/events)

**Works on:** Outside maps, indoor maps, caves, forests, dungeons - ANY map type!

---

## Map Types & Configuration

### Configuring Map Lighting Type

Define map lighting settings in `[001] GameData.rb`:

```ruby
# Default map (ID: 0) - Used when no specific map is configured
GameData::LightMap.register({
  :id => 0,
  :type => :night,  # :night, :cave, :forest, :custom
  :tone => nil,
  :overlay => nil
})

# Example: Cave map
GameData::LightMap.register({
  :id => 15,        # Map ID
  :type => :cave,
  :tone => Tone.new(-80, -80, -60, 100),  # Dark bluish tone
  :overlay => [Color.new(0, 0, 0, 180), 96, 2]  # [Color, radius, rings]
})

# Example: Night-only outdoor map
GameData::LightMap.register({
  :id => 43,
  :type => :night,  # Only applies lighting at night
  :tone => nil,
  :overlay => nil
})
```

### Map Types:

- **`:night`** - Lighting only active at night (outdoor maps)
- **`:cave`** - Always dark (caves, dungeons, indoor darkness)
- **`:forest`** - Medium darkness (forests, dense areas)
- **`:custom`** - Custom lighting behavior with spawn_proc

---

## Adding Light Sources

All lights are defined in `[004] Map_Lights.rb`. There are three ways to add lights:

### Method 1: Single Light Addition

```ruby
GameData::LightEffect.add({
  :id => :my_light_id,
  :type => :circle,
  :radius => 64,
  :map_x => 12,
  :map_y => 22,
  :map_id => 43,
  :day => false
})
```

### Method 2: Bulk Add Circle Lights

```ruby
# Add multiple circle lights at once
GameData::LightEffect.bulk_add_circle(
  43,  # Map ID
  [
    [12, 22],  # [x, y] coordinates
    [15, 22],
    [18, 22]
  ],
  64,    # Radius (default: 64)
  false  # day (show during day? default: false)
)
```

### Method 3: Helper Function (For Repetitive Patterns)

```ruby
# See "Rectangle Lights" section below
```

---

## Circle Lights (Lamps, Torches)

Circle lights create a radial glow effect. Perfect for:

- Street lamps
- Torches
- Chandeliers
- Campfires
- Glowing objects

### Basic Circle Light

```ruby
GameData::LightEffect.add({
  :id => :streetlamp_001,
  :type => :circle,
  :radius => 64,        # Light radius in pixels (32, 64, 96, 128)
  :map_x => 12,         # Tile X coordinate
  :map_y => 22,         # Tile Y coordinate
  :map_id => 43,        # Map ID
  :day => false,        # false = night only, true = always visible
  :stop_anim => false,  # false = pulsating, true = static
  :hide => false        # false = visible, true = hidden
})
```

### Example: Map 43, Tiles 012/022

This is how you add a circle light at coordinates (12, 22) on Map 43:

```ruby
# Single circle light
GameData::LightEffect.add({
  :id => :map43_lamp_12_22,
  :type => :circle,
  :radius => 64,
  :map_x => 12,
  :map_y => 22,
  :map_id => 43,
  :day => false
})
```

### Example: Multiple Circle Lights

```ruby
# Add 5 street lamps on Map 5
GameData::LightEffect.bulk_add_circle(
  5,  # Map ID
  [
    [10, 15],  # Lamp 1
    [15, 15],  # Lamp 2
    [20, 15],  # Lamp 3
    [25, 15],  # Lamp 4
    [30, 15]   # Lamp 5
  ],
  80,    # Larger radius for street lamps
  false  # Night only
)
```

### Radius Guidelines:

- **32px** - Small glow (candles, small lights)
- **64px** - Standard (lamps, torches) **← Most common**
- **96px** - Large (street lamps, chandeliers)
- **128px** - Very large (bonfires, large light sources)

---

## Rectangle Lights (Windows)

Rectangle lights create a square/rectangular glow. Perfect for:

- Windows (especially illuminated at night)
- Doorways
- Light panels
- Glowing tiles

### Basic Rectangle Light

```ruby
GameData::LightEffect.add({
  :id => :window_001,
  :type => :rect,
  :width => 1,          # Width in tiles (1-4)
  :height => 1,         # Height in tiles (1-4)
  :map_x => 9,          # Tile X coordinate
  :map_y => 18,         # Tile Y coordinate
  :map_id => 43,        # Map ID
  :day => false,        # false = night only
  :stop_anim => false   # false = pulsating
})
```

### Example: 4x3 Window Grid (Map 43, Purple House)

This example shows how to efficiently add a grid of window lights:

```ruby
# Define constants
PURPLE_HOUSE_MAP_ID = 43
PURPLE_HOUSE_BASE_X = 9
PURPLE_HOUSE_BASE_Y = 18

# Helper function for easy window addition
def add_window_light(id, x_offset, y_offset)
  GameData::LightEffect.add({
    :id => id,
    :type => :rect,
    :width => 1,
    :height => 1,
    :map_x => PURPLE_HOUSE_BASE_X + x_offset,
    :map_y => PURPLE_HOUSE_BASE_Y + y_offset,
    :map_id => PURPLE_HOUSE_MAP_ID,
    :day => false,
    :stop_anim => false
  })
end

# Add 4x3 grid of windows
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
```

**Result:** A 4-tile wide, 3-tile tall grid of glowing windows starting at (9, 18).

---

## Custom Bitmap Lights

Use custom PNG images as light shapes. Perfect for:

- Complex light patterns
- Specific shapes (stars, hearts, etc.)
- Unique glow effects

### Basic Bitmap Light

```ruby
GameData::LightEffect.add({
  :id => :custom_light_001,
  :type => :bitmap,
  :bitmap => "Graphics/Lights/star_glow.png",  # Path to your PNG
  :map_x => 15,
  :map_y => 20,
  :map_id => 10,
  :day => false
})
```

**Note:** Create your bitmap files in `Graphics/Lights/` folder (you may need to create this folder).

---

## Day/Night Settings

### Night-Only Lights (Most Common)

```ruby
GameData::LightEffect.add({
  :id => :night_lamp,
  :type => :circle,
  :radius => 64,
  :map_x => 10,
  :map_y => 10,
  :map_id => 5,
  :day => false  # ← Only visible at night
})
```

### Always-On Lights (Caves, Indoors)

```ruby
GameData::LightEffect.add({
  :id => :cave_torch,
  :type => :circle,
  :radius => 80,
  :map_x => 8,
  :map_y => 12,
  :map_id => 15,
  :day => true  # ← Always visible (ignore day/night)
})
```

### Pro Tip: Use `:day => true` for:

- Cave torches
- Indoor lights that should always be on
- Emergency lights
- Any light in a `:cave` type map

---

## Works on ALL Map Types

**Yes, the lighting system works everywhere!**

### ✅ Outside Maps

- Streets with lamps
- Houses with glowing windows
- Campfires in fields
- Night-only lighting

### ✅ Indoor Maps

- Interior lights
- Chandeliers
- Candles
- Always-on or night-conditional

### ✅ Caves & Dungeons

- Torches on walls
- Glowing crystals
- Lava glow
- Set `:day => true` for always-on

### ✅ Forests

- Fireflies (small radius)
- Glowing mushrooms
- Camp lights

**Configuration:**

```ruby
# Cave map (always dark)
GameData::LightMap.register({
  :id => 20,
  :type => :cave,
  :tone => Tone.new(-80, -80, -60, 100)
})

# Add torches (always visible)
GameData::LightEffect.bulk_add_circle(
  20,  # Cave map ID
  [
    [5, 8],
    [15, 8],
    [25, 8]
  ],
  72,   # Radius
  true  # day = true → Always visible in cave
)
```

---

## Debug Tools

### Show Current Position

Press **Ctrl + USE** (default: C key) while in-game to display:

- Current X, Y coordinates
- Current Map ID

### Debug Menu

Access via Debug Menu → **Lighting System**:

1. **Add Circle Light Here** - Adds a circle light at player position
2. **Add Rect Light Here** - Adds a rectangle light at player position
3. **List All Lights** - Shows all lights on current map
4. **Remove Nearest Light** - (Not yet implemented)
5. **Toggle All Lights** - Flicker all lights on/off

### Using Debug Tools:

1. Walk to the position where you want a light
2. Press **Ctrl + C** to see coordinates
3. Open Debug Menu → Lighting System
4. Add light and test
5. Copy coordinates to `[004] Map_Lights.rb`

---

## Examples

### Example 1: Simple Street Lamp (Map 5)

```ruby
GameData::LightEffect.add({
  :id => :street_lamp_main_01,
  :type => :circle,
  :radius => 80,
  :map_x => 15,
  :map_y => 10,
  :map_id => 5,
  :day => false
})
```

### Example 2: Row of Torches in Cave (Map 10)

```ruby
# Cave map setup
GameData::LightMap.register({
  :id => 10,
  :type => :cave,
  :tone => Tone.new(-90, -90, -70, 120)
})

# Add torches
GameData::LightEffect.bulk_add_circle(
  10,
  [
    [8, 15],
    [12, 15],
    [16, 15],
    [20, 15]
  ],
  70,
  true  # Always on in cave
)
```

### Example 3: House with Glowing Windows (Map 43)

```ruby
# See "Rectangle Lights" section above for full example
# Result: 4x3 grid of windows that glow at night
```

### Example 4: Mixed Lights on One Map

```ruby
# Map 25: Village at night

# Street lamps (circles)
GameData::LightEffect.bulk_add_circle(25, [
  [10, 15], [20, 15], [30, 15]
], 84, false)

# House windows (rectangles)
GameData::LightEffect.add({
  :id => :house_window_1,
  :type => :rect,
  :width => 2,
  :height => 2,
  :map_x => 25,
  :map_y => 18,
  :map_id => 25,
  :day => false
})

# Campfire (large circle with no animation)
GameData::LightEffect.add({
  :id => :campfire_center,
  :type => :circle,
  :radius => 120,
  :map_x => 35,
  :map_y => 35,
  :map_id => 25,
  :day => false,
  :stop_anim => false  # Keep pulsating for fire effect
})
```

---

## Quick Reference

### Light Types

| Type      | Use Case               | Key Parameters          |
| --------- | ---------------------- | ----------------------- |
| `:circle` | Lamps, torches, fires  | `radius` (32-128)       |
| `:rect`   | Windows, doors, panels | `width`, `height` (1-4) |
| `:bitmap` | Custom shapes          | `bitmap` (PNG path)     |

### Common Radii

- 32 = Small (candle)
- 64 = Standard (lamp) **← Most common**
- 80 = Large (streetlight)
- 96 = Very large (chandelier)
- 128 = Huge (bonfire)

### Day/Night

- `day: false` = Night only (outdoor maps)
- `day: true` = Always on (caves, indoors)

### Finding Coordinates

1. Walk to position
2. Press **Ctrl + C** (or Ctrl + USE)
3. Note X, Y, Map ID
4. Add to `[004] Map_Lights.rb`

---

## Troubleshooting

**Q: Lights not showing up?**

- Check Map ID matches
- Verify coordinates are correct
- For outdoor maps: Is it nighttime? (Use `:day => true` to test)
- Check if map has a LightMap configuration

**Q: Lights showing during day when they shouldn't?**

- Set `:day => false` in light definition

**Q: Want lights to work in caves?**

- Set map type to `:cave` in LightMap.register
- Set `:day => true` for all lights on that map

**Q: How to find exact tile coordinates?**

- Use Debug Tool: Press **Ctrl + C** at the tile location

---

## Summary

1. **Configure your map** in `[001] GameData.rb` (`:night`, `:cave`, etc.)
2. **Add lights** in `[004] Map_Lights.rb`
3. **Use circle lights** for lamps/torches
4. **Use rect lights** for windows
5. **Use Ctrl + C** to find coordinates
6. **Set `:day => false`** for night-only lights
7. **Set `:day => true`** for caves/always-on lights

**Works on ALL maps:** outdoor, indoor, caves, forests, dungeons!

---

**Credits:** Nononever  
**Version:** 1.0  
**Compatible with:** Pokémon Essentials v21.1
