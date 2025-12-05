# Dark Grass Encounters Plugin
**Version:** 1.0.0  
**For:** Pokémon Essentials v21.1  
**Credits:** Juliorain, Vendily (original v19 script), ported to v21.1

## Description

This plugin adds Dark Grass encounters similar to those found in Pokémon Black/White and Black 2/White 2. Dark Grass provides a way to have different wild Pokémon encounters on special grass tiles, and can optionally play different battle music.

This system can be extended for other special grass types like Flabébé flowers or Oricorio nectar meadows.

## Features

- **New Terrain Tag:** `DarkGrass` (ID: 18)
- **New Encounter Types:** `DarkGrass` and time-based variants (`DarkGrassDay`, `DarkGrassNight`, `DarkGrassMorning`, `DarkGrassAfternoon`, `DarkGrassEvening`)
- **Custom Battle Music:** Optional custom BGM for dark grass encounters
- **Double Encounters:** Dark grass supports double wild battles (30% chance)
- **Grass Rustle Animation:** Shows the grass rustle animation when walking through
- **Fully Compatible:** Works alongside normal grass and other encounter types

## Installation

1. Copy the `Dark Grass Encounters` folder into your `Plugins` directory
2. The plugin will automatically load with your game
3. Compile your game (delete `Data/PluginScripts.rxdata` if needed)

## Setup & Usage

### Step 1: Add Dark Grass to Your Tileset

1. Open your tileset in the Essentials Editor or your graphics editor
2. Add a visual variant of grass that looks "darker" or different from normal grass
3. Save your tileset changes

### Step 2: Assign Terrain Tag

1. Open your game in Debug mode (F8)
2. Open the Essentials Editor (F9)
3. Go to the map where you want dark grass
4. Select the tile(s) you want to be dark grass
5. In the Terrain Tag section, assign **Terrain Tag 18 (DarkGrass)**

### Step 3: Define Encounters

Edit your map's encounters in `PBS/encounters.txt`:

```ruby
# Example encounters for Map 1
[001]
# Normal grass encounters
Land,12,10,10,10,10,8,8,8,8,6,6,4,4
  PIDGEY,10,14
  RATTATA,10,14
  PIDGEY,12,16
  # ... etc

# Dark grass encounters
DarkGrass,12,10,10,10,10,8,8,8,8,6,6,4,4
  FEAROW,15,20
  RATICATE,15,20
  PIDGEOTTO,18,22
  # ... etc (different or stronger Pokémon)
```

**Time-based encounters (optional):**

```ruby
# Different Pokémon appear in dark grass during day vs night
DarkGrassDay,12,10,10,10,10,8,8,8,8,6,6,4,4
  PIDGEY,12,16
  RATTATA,12,16

DarkGrassNight,12,10,10,10,10,8,8,8,8,6,6,4,4
  HOOTHOOT,12,16
  MURKROW,12,16
```

### Step 4: Custom Battle Music (Optional)

#### Method 1: Default Dark Grass BGM

Edit `Plugins/Dark Grass Encounters/003_BattleAudio.rb` and uncomment this line:

```ruby
# ret = pbStringToAudioFile("Battle dark grass") if !ret
```

Change `"Battle dark grass"` to your audio filename (without extension).
Place your audio file in `Audio/BGM/`

#### Method 2: Per-Map Dark Grass BGM

1. Open `PBS/map_metadata.txt`
2. Add a custom metadata field for your map:

```ruby
[001]
Name = Route 1
# ... other metadata ...
DarkGrassBattleBGM = your_music_file_name
```

**Note:** This requires modifying the metadata schema. Alternatively, use the global default in the plugin file.

## Technical Details

### Terrain Tag Properties

The DarkGrass terrain tag has these properties:
- `deep_bush = true` - Acts like tall grass (hides player sprite)
- `dgrass_wild_encounters = true` - Enables dark grass encounters
- `double_wild_encounters = true` - Can trigger double battles
- `battle_environment = :TallGrass` - Uses tall grass battle background
- `shows_grass_rustle = true` - Shows grass rustle animation

### Encounter Type

- **Type:** `:darkgrass`
- **Trigger Chance:** 21 (same as normal land encounters)
- **Compatible with:** Time-based encounter variants

### Extending This System

You can easily create additional special grass types:

1. Register a new terrain tag in `001_TerrainTag.rb`
2. Register a new encounter type in `002_EncounterType.rb`
3. Add logic to `encounter_type` method for your new type
4. Define encounters in PBS files

Example for "Flower Meadow":
```ruby
# In 001_TerrainTag.rb
GameData::TerrainTag.register({
  :id                       => :FlowerMeadow,
  :id_number                => 19,
  :flower_encounters        => true,
  :battle_environment       => :Grass
})

# In 002_EncounterType.rb
GameData::EncounterType.register({
  :id             => :FlowerMeadow,
  :type           => :flower,
  :trigger_chance => 21
})
```

## Troubleshooting

### Encounters not triggering
- Verify the terrain tag is correctly assigned (use Debug mode to check)
- Make sure encounters are defined in `encounters.txt` with the correct map ID
- Compile the plugin data (delete `Data/PluginScripts.rxdata`)

### Wrong music playing
- Check that your audio file exists in `Audio/BGM/`
- Verify the filename matches (case-sensitive)
- Make sure you've enabled the custom BGM in the plugin

### Grass doesn't look right
- The visual appearance is controlled by your tileset, not this plugin
- Make sure you assigned the terrain tag to the correct tiles

## Compatibility

- **Pokémon Essentials:** v21.1
- **PokeRadar:** Should be compatible, but may need adjustments
- **Other Plugins:** Generally compatible with most plugins

## Credits

- **Juliorain** - Original concept and v19 implementation
- **Vendily** - Major contributions to v19 version
- **Ported to v21.1** - Adapted for modern Essentials

## License

Free to use in your projects. Credit is appreciated but not required.

## Changelog

### v1.0.0
- Initial release for Pokémon Essentials v21.1
- Ported from v19 script
- Updated to use v21.1 API changes
- Added comprehensive documentation
