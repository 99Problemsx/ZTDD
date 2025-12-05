# Plugin Documentation

Auto-generated documentation for all installed plugins.

Last updated: Fri Dec  5 23:48:47 UTC 2025


---

## Advanced Items Field Moves

**Name**: Advanced Items - Field Moves

**Version**: 2.0.0b [34w25a]

**Author**: 

**Files**: 18 Ruby files


---

## Arcky's Poke Market

**Name**: 

**Version**: 1.6.0

**Author**: 

**Dependencies**:
- Arcky's Utilities
- 1.0.9

**Files**: 5 Ruby files


---

## Arcky's Region Map

**Name**: 

**Version**: 3.2.0

**Author**: 

**Dependencies**:
- Arcky's Utilities
- 1.0.9

**Files**: 35 Ruby files


---

## Arcky's Utilities

**Name**: 

**Version**: 1.0.9

**Author**: 

**Files**: 1 Ruby files


---

## Automatic Level Scaling

**Name**: Automatic Level Scaling

**Version**: 1.6.3

**Author**: 

**Files**: 5 Ruby files


---

## Automatic Trainer Generator

**Name**: Automatic Trainer Generator

**Version**: 1.0

**Author**: 

**Files**: 3 Ruby files


---

## Autosave

**Name**: Autosave

**Version**: 1.0

**Author**: 

**Files**: 1 Ruby files


---

## Autosave Feature

**Name**: Autosave Feature v21

**Version**: 1.5

**Author**: 

**Files**: 1 Ruby files


---

## BW Key Items

**Name**: BW Key Items

**Version**: 2.3.0

**Author**: 

**Files**: 1 Ruby files


---

## BW Mart Screen

**Name**: BW PokéMart Screen

**Version**: 3.0.0

**Author**: 

**Files**: 1 Ruby files


---

## BW Storage System

**Name**: BW Storage System

**Version**: 2.0.0

**Author**: 

**Files**: 2 Ruby files


---

## Bag Screen with interactable Party

**Name**: Bag Screen w/int. Party

**Version**: 2.5.0

**Author**: 

**Files**: 2 Ruby files


---

## Battle Popup Messages

**Name**: Battle Popup Messages

**Version**: 1.0

**Author**: 

**Link**: nein

**Dependencies**:
- [DBK] Enhanced Battle UI
- 2.0.0

**Files**: 1 Ruby files


---

## Battle Speed Control

**Name**: Battle Speed Control

**Version**: 1.2

**Author**: 

**Files**: 1 Ruby files


---

## Beach Water Bubbles

**Name**: Beach Water Bubble Effect

**Version**: 1.0.2

**Author**: 

**Files**: 1 Ruby files


---

## Better Bitmaps

**Name**: Better Bitmaps (Marin)

**Version**: 1.1

**Author**: 

**Link**: https://reliccastle.com/resources/169/

**Files**: 1 Ruby files


---

## Boons_Phenomena

**Name**: N/A

**Version**: 3.1.1

**Author**: 

**Files**: 3 Ruby files


---

## Box Auto-Sort

**Name**: Box Auto-Sort

**Version**: 1.0.0

**Author**: 

**Link**: https://eeveeexpo.com/resources/1733/

**Files**: 4 Ruby files

### Description

# Box Auto-Sort

A comprehensive box sorting plugin for Pokémon Essentials v21.1 that adds sorting functionality to the PC storage system.

## Features

- **12 Sorting Methods**: Level, Alphabetical, Type, Catch Date, Shiny, National Dex, Forms, Friendship, Nature
- **Preview System**: See what the sorting will look like before applying
- **Multiple Storage System Support**: Works with standard Essentials, BW Storage System, and Storage System Utilities
- **Easy Integration**: Adds "Sort" option to the box commands menu
- **Non-Destructive**: Preview before applying changes

## Installation

1. Extract the plugin folder to your `Plugins/` directory
2. The plugin will automatically integrate with your existing storage system
3. No additional configuration required

## How to Use

### Method 1: Box Commands Menu
1. Open the PC storage system
2. Click on any box name
3. Select "Sort" from the menu
4. Choose your preferred sorting method
5. Review the preview and confirm

### Method 2: Direct PC Menu Access
1. Access the PC from any Pokémon Center
2. Select "Box Auto-Sort" from the main menu
3. Choose which box to sort
4. Select your sorting method

## Sorting Methods

| Method | Description |
|--------|-------------|
| Level (Low to High) | Sort from Level 1 to 100 |
| Level (High to Low) | Sort from Level 100 to 1 |
| Alphabetical (A-Z) | Sort alphabetically from A to Z |
| Alphabetical (Z-A) | Sort alphabetically from Z to A |
| Primary Type | Sort by primary type |
| Type Combination | Sort by full type combination |
| Catch Date | Sort by catch date (newest first) |
| Shiny First | Shiny Pokémon appear first |
| National Dex | Sort by National Dex number |
| Forms | Sort by species and form |
| Friendship | Sort by friendship level |
| Nature | Sort by nature alphabetically |

## Compatibility

- **Pokémon Essentials**: v21.1+
- **Storage Systems**: Standard Essentials, BW Storage System, Storage System Utilities
- **Other Plugins**: Automatically detects and integrates with existing storage plugins

## Configuration

The plugin works out of the box with default settings. Advanced users can modify:

- `ENABLED`: Enable/disable the plugin
- `SHOW_PREVIEW`: Show preview before sorting
- `PREVIEW_COUNT`: Number of Pokémon to show in preview

## Credits

Created by Marcel Weidenauer for Pokémon Essentials v21.1

## License

Free to use and modify for non-commercial Pokémon fan games. 

---

## Caruban's Map Exporter

**Name**: N/A

**Version**: 1.1

**Author**: 

**Files**: 1 Ruby files


---

## Challenge Modes

**Name**: Challenge Modes

**Version**: 2.2

**Author**: 

**Files**: 17 Ruby files

### Changelog

# Challenge Modes - Changelog

## Version 2.1 - Major Update (November 2025)

### New Challenge Rules (5 Added)

**No Pokémon Centers (Rule 15)**
- Completely blocks all Pokémon Center healing
- Forces players to rely on items and healing moves
- Shows clear rejection messages when attempting to heal

**No Legendaries (Rule 16)**
- Prevents catching Legendary and Mythical Pokémon
- Blocks Poké Ball usage on legendaries in battle
- Automatically detects Pokémon with "Legendary" or "Mythical" flags
- Legendary encounters still occur but cannot be captured

**Limited Healing (Rule 17)**
- Limits Pokémon Center visits to 3 per town/area
- Tracks healing counter per map ID
- Shows remaining heals after each visit
- Configurable limit via LIMITED_HEALING_COUNT constant

**Species Clause (Rule 18)**
- Only allows one Pokémon of each species in party
- Blocks catching duplicate species
- Automatically sends duplicates to PC
- Checks base species (ignores forms)

**Item Restrictions (Rule 19)**
- Bans all X-Items in battle (X Attack, X Defense, X Speed, etc.)
- Limits Revive usage to 3 per battle
- Limits Max Revive usage to 3 per battle
- Limits Full Restore usage to 3 per battle
- Counter resets at start of each battle
- Shows remaining uses when items are used

### Rule Count
- Total rules increased from 14 to 19
- All new rules fully documented in COMPLETE_GUIDE.md

### Compatibility Improvements

**Level Caps EX Integration**
- Added runtime detection for Level Caps EX plugin
- LEVEL_CAP rule only visible when plugin is installed
- Challenge Modes works standalone without Level Caps EX
- Level Caps EX works standalone without Challenge Modes
- No conflicts between plugins



---

## Charms Compilation

**Name**: Charms Compilation

**Version**: 1.4.3

**Author**: 

**Link**: https://reliccastle.com/resources/1389/

**Files**: 51 Ruby files


---

## Combate Estilo EBDX

**Name**: Combate Estilo EBDX

**Version**: 1.0.4

**Author**: 

**Dependencies**:
- [DBK] Enhanced Battle UI
- 2.0

**Files**: 4 Ruby files


---

## Custom Battle Environments

**Name**: 

**Version**: 1.0.0

**Author**: 

**Files**: 2 Ruby files


---

## Dark Grass Encounters

**Name**: Dark Grass Encounters

**Version**: 1.0.0

**Author**: 

**Link**: no

**Files**: 4 Ruby files

### Description

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

### Changelog

# Dark Grass Encounters - Changelog

## Version 1.0.0 (November 18, 2025)

### Initial Release
- Ported Dark Grass system from Pokémon Essentials v19 to v21.1
- Complete rewrite to match v21.1 API changes

### Features Added
- New `DarkGrass` terrain tag (ID: 18)
- New encounter type `:darkgrass` with time-based variants
- Support for custom battle BGM in dark grass
- Double wild battle support (30% chance)
- Grass rustle animation support
- Fully compatible with existing encounter systems

### Files Included
- `001_TerrainTag.rb` - Terrain tag definition and registration
- `002_EncounterType.rb` - Encounter type and logic modifications
- `003_BattleAudio.rb` - Custom BGM support for dark grass
- `004_MapMetadata_OPTIONAL.rb` - Optional per-map BGM support (commented out)
- `meta.txt` - Plugin metadata
- `README.md` - Complete documentation
- `QUICK_START.md` - Quick setup guide
- `EXAMPLES.txt` - Example encounter configurations
- `CHANGELOG.md` - This file

### Technical Details
- Compatible with Pokémon Essentials v21.1
- No conflicts with core scripts (uses aliases)
- Extensible design for additional grass types

### Credits
- Original v19 script by Juliorain and Vendily
- Ported to v21.1 by [Your Name]

---

## Future Planned Features

### Version 1.1.0 (Planned)
- [ ] PokeRadar full compatibility testing
- [ ] Support for additional special grass types (Flower Meadow example)
- [ ] Configuration file for easy customization
- [ ] Debug menu integration for testing

### Version 1.2.0 (Planned)
- [ ] Visual effects when entering dark grass
- [ ] Sound effects for dark grass steps
- [ ] Rare encounter boost option (like Gen 5 dark grass)


---

## Delta Speed Up

**Name**: Delta Speed Up

**Version**: 1.2

**Author**: 

**Dependencies**:
- v21.1 Hotfixes

**Files**: 1 Ruby files


---

## Dynamic Battle Backdrop

**Name**: Dynamic Battle Backdrop

**Version**: 1.0

**Author**: 

**Link**: no

**Files**: 1 Ruby files


---

## Egg Steps Display

**Name**: Egg Steps Display

**Version**: 1.0

**Author**: 

**Files**: 3 Ruby files


---

## Enemy HP Percentage Display

**Name**: Enemy HP Percentage Display

**Version**: 1.0

**Author**: 

**Files**: 1 Ruby files


---

## Essentials-SpeciesIntro

**Name**: Species Display

**Version**: 1.0

**Author**: 

**Files**: 2 Ruby files


---

## Event Indicators

**Name**: Event Indicators

**Version**: 1.3

**Author**: 

**Files**: 3 Ruby files


---

## Event Templating System

**Name**: Event Templating System

**Version**: 1.0.0

**Author**: 

**Files**: 3 Ruby files

### Description

# Event Templating System

Ein Template-System für Events wie von Luka - definiere Events in Ruby statt im RMXP Editor!

## Warum?

- **Kein RMXP Editor nötig**: Alles in Ruby Code
- **Wiederverwendbar**: Einmal definieren, überall nutzen
- **Übersichtlich**: Code ist lesbarer als Event-Commands
- **Versionskontrolliert**: Git kann Events tracken
- **Schnell**: Copy-Paste statt mühsames Event-Klicken

## Installation

Das Plugin ist bereits aktiv. Einfach Templates definieren und nutzen!

## Grundlegendes

### Template definieren

```ruby
event_template :mein_template do |param1:, param2: "default"|
  message("Hallo #{param1}!")
  give_item(param2, 1)
end
```

### Template benutzen

**In einem Event (Script-Command):**

```ruby
EventTemplates.execute(:mein_template, param1: "Welt", param2: :POTION)
```

**In anderem Template:**

```ruby
event_template :wrapper do
  use_template(:mein_template, param1: "Nested", param2: :POKEBALL)
end
```

## Verfügbare Befehle

### Nachrichten & Text

- `message(text)` - Zeige Textbox
- `choices(["Option 1", "Option 2"])` - Zeige Auswahlmenü
- `sign(text:)` - Template für Schilder

### Items & Geld

- `give_item(item, quantity)` - Gebe Item
- `give_money(amount)` - Gebe/nehme Geld
- `open_mart(items)` - Öffne Shop
- `shop(items:, greeting:, farewell:)` - Shop-Template

### Pokémon

- `give_pokemon(species, level, **options)` - Gebe Pokémon
  - Optionen: `:item`, `:shiny`, `:gender`, `:form`, `:nature`, `:moves`
- `heal_party()` - Heile Team
- `battle_wild(species, level)` - Wild-Kampf
- `battle_wild_ex(species, level, **options)` - Wild-Kampf mit Optionen
- `battle_trainer(type, name, version)` - Trainer-Kampf
- `evolve_pokemon(species)` - Evolution auslösen
- `send_to_storage(species, level, **options)` - Direkt zu Box
- `create_roaming(species, level, **options)` - Roaming Pokemon

### Conditionals (Bedingungen)

- `if_switch(switch_id) { ... }` - Prüfe Switch
- `if_has_item(item, quantity) { ... }` - Prüfe Item
- `if_has_pokemon(species) { ... }` - Prüfe Pokémon im Team
- `if_has_badge(badge_id) { ... }` - Prüfe Badge
- `if_value(expression) { ... }` - Prüfe beliebigen Wert

### Switches & Variables

- `set_switch(switch_id, value)` - Setze Switch
- `set_variable(var_id, value)` - Setze Variable

### Audio

- `play_se(filename, volume, pitch)` - Sound Effect
- `play_me(filename, volume, pitch)` - Music Effect
- `play_bgm(filename, volume, pitch)` - Background Music

### Effekte & Visuals

- `fade_screen()` - Fade out/in
- `show_picture(id, name, x, y)` - Zeige Bild
- `erase_picture(id)` - Entferne Bild
- `show_animation(anim_id, target)` - Spiele Animation
- `change_weather(type, duration)` - Ändere Wetter

### Movement & Transfer

- `transfer_player(map_id, x, y, direction)` - Teleportiere Spieler
- `move_event(event_id, direction, speed)` - Bewege Event
- `wait(frames)` - Warte

### Sonstiges

- `open_pc()` - Öffne PC
- `script(code)` - Führe Ruby-Code aus
- `call_common_event(event_id)` - Rufe Common Event auf

## Vorgefertigte Templates

### Item Ball

```ruby
EventTemplates.execute(:item_ball, item: :POTION, quantity: 1)
```

### Hidden Item

```ruby
EventTemplates.execute(:hidden_item, item: :RARECANDY)
```

### Nurse Joy (Pokémon Center)

```ruby
EventTemplates.execute(:nurse_joy)
# Oder mit custom Text:
EventTemplates.execute(:nurse_joy,
  greeting: "Willkommen!",
  farewell: "Bis bald!"
)
```

### Trainer Battle

```ruby
EventTemplates.execute(:trainer_battle,
  trainer_type: :YOUNGSTER,
  trainer_name: "Joey",
  intro: "My Rattata is in the top percentage!",
  after_text: "No way!",
  switch: 100  # Switch 100 wird nach Sieg gesetzt
)
```

### Gift Pokémon

```ruby
EventTemplates.execute(:gift_pokemon,
  species: :PIKACHU,
  level: 5,
  item: :LIGHTBALL,
  shiny: false,
  nature: :JOLLY,
  moves: [:THUNDERBOLT, :QUICKATTACK, :IRONTAIL, :SURF],
  text_before: "Take this Pikachu!",
  text_after: "It's very special!"
)
```

### Shop

```ruby
EventTemplates.execute(:shop,
  items: [:POKEBALL, :POTION, :ANTIDOTE, :PARALYZEHEAL, :AWAKENING, :BURNHEAL]
)
```

### Berry Tree

```ruby
EventTemplates.execute(:berry_tree, berry: :ORANBERRY, quantity: 3)
```

### Cut Tree

```ruby
EventTemplates.execute(:cut_tree)
```

### Rock Smash (mit verstecktem Item)

```ruby
EventTemplates.execute(:smash_rock, item: :STARPIECE)
```

### Rock Smash (mit verstecktem Pokémon)

```ruby
EventTemplates.execute(:smash_rock,
  pokemon_species: :SHUCKLE,
  pokemon_level: 10
)
```

### Roaming Legendary

```ruby
EventTemplates.execute(:release_roaming,
  species: :ENTEI,
  level: 40,
  text: "Entei fled into the distance!"
)
```

### Gym Leader

```ruby
EventTemplates.execute(:gym_leader,
  trainer_type: :LEADER_Brock,
  trainer_name: "Brock",
  badge_id: 0,
  badge_name: "Boulder Badge",
  tm_item: :TM39,  # Rock Tomb
  prize_money: 8000,
  intro: "I'll show you the power of Rock types!",
  defeat_text: "Your Pokémon's strength overcame my rocks!",
  badge_text: "You've earned the Boulder Badge!"
)
```

### Locked Door

```ruby
EventTemplates.execute(:locked_door,
  key_item: :CARDKEY,
  target_map: 5,
  target_x: 10,
  target_y: 15
)
```

### Legendary Encounter

```ruby
EventTemplates.execute(:legendary_encounter,
  species: :MEWTWO,
  level: 70,
  text_before: "A mysterious force is blocking your path!",
  text_caught: "You caught Mewtwo!",
  text_defeat: "Mewtwo vanished!"
)
```

## Eigene Templates erstellen

### Einfaches Template

```ruby
event_template :my_simple_event do
  message("Hello!")
  give_item(:POTION, 5)
  heal_party
end
```

### Template mit Parametern

```ruby
event_template :give_starter do |species:, nickname: nil|
  message("Professor: Here's your first Pokémon!")
  give_pokemon(species, 5, moves: [:TACKLE, :GROWL])
  message("Take good care of #{species}!")
end

# Nutzen:
EventTemplates.execute(:give_starter, species: :BULBASAUR)
```

### Template mit Conditionals

```ruby
event_template :daily_berry do |berry:|
  if_switch(500) do  # Switch 500 = Heute schon bekommen
    message("Come back tomorrow for more berries!")
  end.else do
    message("Here's today's berry!")
    give_item(berry, 1)
    set_switch(500, true)
  end
end
```

### Verschachteltes Template

```ruby
event_template :full_heal_service do |price: 500|
  message("I can heal your Pokémon for $#{price}!")
  choices(["Yes", "No"]) do |choice|
    if choice == 0
      if_value("$player.money >= #{price}") do
        give_money(-price)
        heal_party
        message("Your Pokémon are healed!")
      end.else do
        message("You don't have enough money!")
      end
    else
      message("Come back if you change your mind!")
    end
  end
end
```

## Integration mit Map System

Du kannst Templates mit dem Map Trainer System kombinieren:

```ruby
# In PBS/Maps/Trainers.rb
module Data::Trainers
  class Map5 < GameData::MapTrainer
    register 10, :YOUNGSTER, "Joey" do |trainer|
      trainer.intro = "My Rattata is different!"
      trainer.lose_text = "What?!"
      trainer.party = [
        Pokemon.new(:RATTATA, 15).with_item(:FOCUSSASH)
      ]
    end
  end
end

# Im Event (Script-Command):
# Statt manuell pbTrainerBattle zu callen:
EventTemplates.execute(:trainer_battle,
  trainer_type: :YOUNGSTER,
  trainer_name: "Joey",
  switch: 100
)
```

## Best Practices

### 1. Template-Namen beschreibend wählen

```ruby
# Gut:
event_template :gym_entrance_guard
event_template :mystery_gift_deliverer

# Schlecht:
event_template :event1
event_template :thing
```

### 2. Defaults für optionale Parameter

```ruby
event_template :healer do |price: 0, message: "Would you like me to heal your Pokémon?"|
  # ...
end
```

### 3. Switches für einmalige Events

```ruby
event_template :story_event do
  if_switch(200) do
    message("That already happened.")
  end.else do
    message("Important story moment!")
    # ... story stuff ...
    set_switch(200, true)
  end
end
```

### 4. Gruppiere verwandte Templates

```ruby
# Alle Gym-Leader in einem File
event_template :gym_1_brock do |...|
event_template :gym_2_misty do |...|
event_template :gym_3_surge do |...|
```

### 5. Nutze `use_template` für Wiederverwendung

```ruby
event_template :postgame_trainer do |trainer_type:, name:|
  message("A strong trainer approaches!")
  use_template(:trainer_battle,
    trainer_type: trainer_type,
    trainer_name: name,
    switch: nil  # Repeatable
  )
end
```

## Debugging

### Template existiert nicht?

```ruby
if EventTemplates.exists?(:my_template)
  EventTemplates.execute(:my_template)
else
  puts "Template not found!"
end
```

### Alle Templates anzeigen

```ruby
p EventTemplates.instance_variable_get(:@templates).keys
```

### Template testen

```ruby
# In Debug Console (F12):
EventTemplates.execute(:item_ball, item: :MASTERBALL)
```

## Erweiterte Beispiele

### Multi-Stage Event (Questline)

```ruby
event_template :scientist_quest do
  if_switch(301) do
    # Stage 3: Completed
    message("Thanks for the fossils! Here's your reward!")
    if_has_item(:HELIXFOSSIL) do
      message("Oh, you have another fossil? Let me revive it!")
      # Revive logic
    end
  elsif_switch(300) do
    # Stage 2: Task given
    if_has_item(:HELIXFOSSIL) && if_has_item(:DOMEFOSSIL) do
      message("You found both fossils! Amazing!")
      give_item(:MASTERBALL, 1)
      give_money(10000)
      set_switch(301, true)
    end.else do
      message("Still searching for those fossils?")
    end
  end.else do
    # Stage 1: Introduction
    message("I'm researching ancient Pokémon!")
    message("Could you find me a Helix Fossil and Dome Fossil?")
    set_switch(300, true)
  end
end
```

### Dynamic Trainer Battle (ändert sich mit Story)

```ruby
event_template :rival_dynamic do
  if_has_badge(8) do
    # Post-game Rival
    battle_trainer(:RIVAL, "Blue", 5)
  elsif_has_badge(4) do
    # Mid-game Rival
    battle_trainer(:RIVAL, "Blue", 3)
  end.else do
    # Early-game Rival
    battle_trainer(:RIVAL, "Blue", 1)
  end
end
```

### Time-based Event

```ruby
event_template :daily_lottery do
  # Pseudo-Code, Zeit-Check müsste implementiert werden
  script("today = Time.now.strftime('%Y-%m-%d')")

  if_value("$game_variables[100] == today") do
    message("Come back tomorrow for another chance!")
  end.else do
    message("Welcome to the daily lottery!")
    # Lottery logic
    script("$game_variables[100] = today")
  end
end
```

## FAQ

**Q: Kann ich RMXP Events und Templates mischen?**  
A: Ja! Du kannst aus RMXP-Events `EventTemplates.execute()` callen.

**Q: Funktionieren alte Events noch?**  
A: Ja, das System ist komplett optional.

**Q: Wie kann ich Parameter an Templates übergeben?**  
A: Mit Ruby's Keyword Arguments: `EventTemplates.execute(:name, param1: value1)`

**Q: Kann ich Templates in anderen Plugins definieren?**  
A: Ja! Einfach `event_template :name do ... end` irgendwo schreiben.

**Q: Werden Templates kompiliert?**  
A: Nein, wie bei Luka's System - sie werden direkt geladen und ausgeführt.

## Vergleich zu RMXP Events

### RMXP (Old Way):

1. Öffne Editor
2. Erstelle Event
3. Doppelklick für Event Commands
4. Füge 20+ Commands manuell hinzu
5. Copy-Paste ist mühsam
6. Keine Versionskontrolle
7. Schwer zu teilen

### Templates (New Way):

```ruby
EventTemplates.execute(:item_ball, item: :POTION)
```

**Eine Zeile. Fertig.**

## Credits

Based on Luka's templating philosophy: "I made an entire templating engine for events and rewrote most of the PBS based components into something I like more. Don't have to leave the IDE much at all these days."


---

## Fly Animation

**Name**: 

**Version**: 3.0.1

**Author**: 

**Files**: 3 Ruby files


---

## Following Pokemon EX

**Name**: Following Pokemon EX

**Version**: 2.3.1

**Author**: 

**Files**: 16 Ruby files


---

## Generation 9 Pack Scripts

**Name**: Generation 9 Pack

**Version**: 3.3.2

**Author**: 

**Dependencies**:
- v21.1 Hotfixes
- 1.0.9

**Files**: 26 Ruby files


---

## Hidden Ability Encounters

**Name**: Hidden Ability Encounters

**Version**: 1.0

**Author**: 

**Files**: 2 Ruby files


---

## Improved Pokecenter Healing Balls

**Name**: Improved PC Healing Balls

**Version**: 1.0.0

**Author**: 

**Files**: 1 Ruby files


---

## Item Find Description

**Name**: Item Find Description

**Version**: 2.1

**Author**: 

**Files**: 1 Ruby files


---

## Level Caps EX

**Name**: Level Caps EX

**Version**: 2.3

**Author**: 

**Dependencies**:
- v21.1 Hotfixes
- 1.0.9

**Files**: 3 Ruby files


---

## Lin's Weather System

**Name**: N/A

**Version**: 1.4.0

**Author**: 

**Link**: https://eeveeexpo.com/resources/1411/

**Files**: 14 Ruby files


---

## Literal Color Change

**Name**: Literal Color Change

**Version**: 1.0

**Author**: 

**Files**: 1 Ruby files


---

## Luka's Scripting Utilities

**Name**: N/A

**Version**: 4.0.2

**Author**: 

**Files**: 34 Ruby files


---

## MAG

**Name**: 

**Version**: 0.0.1

**Author**: 

**Dependencies**:
- Generation 9 Pack
- 3.2.7

**Files**: 76 Ruby files


---

## Multiple Item Use

**Name**: Multiple Item Use

**Version**: 1.0.0

**Author**: 

**Files**: 1 Ruby files


---

## Overworld Encounters

**Name**: N/A

**Version**: 2.0

**Author**: 

**Link**: https://voltseon.com/

**Dependencies**:
- rainefallUtils

**Files**: 4 Ruby files


---

## Overworld Shadows

**Name**: Overworld Shadows

**Version**: 1.0.1

**Author**: 

**Dependencies**:
- Luka's Scripting Utilities
- 4.0.2

**Files**: 1 Ruby files


---

## Overworld Weather Enhancements

**Name**: Overworld Weather Enhancements

**Version**: 2.0

**Author**: 

**Files**: 1 Ruby files


---

## Passcodes

**Name**: Passwords

**Version**: 1.0

**Author**: 

**Files**: 1 Ruby files


---

## Permanent Repel

**Name**: Permanent Repel System

**Version**: 1.0

**Author**: 

**Files**: 1 Ruby files


---

## Pokémon League Transitions

**Name**: Pokémon League Transitions

**Version**: 1.1

**Author**: 

**Link**: https://eeveeexpo.com/resources/1641/

**Files**: 3 Ruby files


---

## RMXP Event Importer

**Name**: RMXP Event Importer

**Version**: 1.4.1

**Author**: 

**Link**: https://reliccastle.com/resources/394/

**Files**: 3 Ruby files

### Description

# RMXP Event Importer Plugin

## Version 1.3 - Complete Edition

Create RPG Maker XP events from simple text files!

## 🎯 Features

- ✅ Create events from text files
- ✅ Update existing events automatically (no duplicates!)
- ✅ **50+ RMXP event commands** supported
- ✅ **Multiple event pages** with conditions
- ✅ **Move routes with 40+ movement commands**
- ✅ Compatible with RMXP Event Exporter
- ✅ Visible in RPG Maker XP editor
- ✅ Auto-import on game startup
- ✅ Debug menu integration

## 📦 Installation

1. Copy the `RMXP Event Importer` folder to `Plugins/`
2. Create the `EventImporter/` folder in your project root
3. Place your event text files in `EventImporter/`
4. Start the game - events will be imported automatically!

## 📝 Basic Format

```
MAP: 3

EVENT: NPC Name, X: 10, Y: 5
GRAPHIC: NPC 01
TRIGGER: Action
TEXT: Hello! I'm an NPC.
TEXT: This is line 2.
```

**⚠️ IMPORTANT**: Do NOT put empty lines within an event definition! Empty lines mark the end of an event.

## 🎮 Event Properties

### Basic Properties

```
EVENT: Name, X: x, Y: y          # Event name and position (REQUIRED)
GRAPHIC: filename                 # Character graphic
GRAPHIC: trainer_YOUNGSTER, 0    # With character index
TRIGGER: Action                   # Event trigger type
DIRECTION: Left                   # Initial facing direction
MOVE_TYPE: Random                 # Autonomous movement
MOVE_SPEED: 4                     # Movement speed (1-6)
MOVE_FREQ: 3                      # Movement frequency (1-6)
THROUGH: true                     # Walk through walls
ALWAYS_ON_TOP: true               # Always above player
DIRECTION_FIX: true               # Don't change direction
```

**Trigger Types:** `Action`, `Touch`, `Event_Touch`, `Autorun`, `Parallel`  
**Directions:** `Up`, `Down`, `Left`, `Right`  
**Move Types:** `Fixed`, `Random`, `Approach`, `Custom`

### 📄 Multiple Pages

```
EVENT: Multi Page NPC, X: 12, Y: 5
GRAPHIC: NPC 01
TEXT: This is page 1
SELF_SWITCH: A, ON

NEW_PAGE
GRAPHIC: NPC 02
CONDITION_SELF_SWITCH: A
TEXT: This is page 2 (shows when self switch A is ON)
```

### 🔒 Page Conditions

```
CONDITION_SWITCH: 10, ON              # Require switch 10 to be ON
CONDITION_SELF_SWITCH: A              # Require self switch A
CONDITION_VARIABLE: 5 >= 10           # Require variable 5 >= 10
```

**Operators:** `>=`, `<=`, `==`, `>`, `<`

## 💬 Dialogue & Text Commands

### Simple Text

```
TEXT: Hello there!
TEXT: How are you today?
```

### Choices

```
CHOICE: Yes, No, Maybe
CONDITIONAL: CHOICE == 0
  TEXT: You chose Yes!
CONDITIONAL: CHOICE == 1
  TEXT: You chose No!
CONDITIONAL: ELSE
  TEXT: You chose Maybe!
```

### Scripts

```
SCRIPT: pbMessage("Hello!")
SCRIPT: pbHealAll
SCRIPT: pbTrainerBattle(:YOUNGSTER, "Joey", "You win!", false)
```

**Multi-line scripts:**

```
SCRIPT: pbPokemonMart([
SCRIPT:   :POTION,
SCRIPT:   :POKEBALL,
SCRIPT:   :ANTIDOTE
SCRIPT: ])
```

## 🥊 Trainer Battles (MapTrainer System)

The Event Importer includes an integrated trainer system that makes creating trainer battles easy!

### Basic Trainer

```
EVENT: Camper Liam, X: 10, Y: 5
GRAPHIC: trainer_CAMPER
TRIGGER: Action
CONDITIONAL: SELF_SWITCH A == OFF
  TEXT: Want to battle?
  MAPTRAINER: CAMPER, Liam, "You won!"
    POKEMON: RATTATA, 5
    POKEMON: PIDGEY, 6
  END_MAPTRAINER
CONDITIONAL: ELSE
  TEXT: Good battle!
```

### Advanced Trainer with Items

```
MAPTRAINER: YOUNGSTER, Ben, "I lost!"
  TRAINER_INTRO: I'll be the best!
  TRAINER_ITEMS: POTION, POKEBALL
  POKEMON: CATERPIE, 7, moves: TACKLE, STRING_SHOT
  POKEMON: WEEDLE, 7, item: ORAN_BERRY
END_MAPTRAINER
```

### Pokemon with Abilities & Gender

```
POKEMON: PIKACHU, 10, ability: STATIC, item: LIGHT_BALL, gender: female
POKEMON: CHARIZARD, 50, ability: BLAZE, moves: FLAMETHROWER, AIR_SLASH, DRAGON_CLAW
```

**Features:**

- ✅ Automatic self-switch management (prevents re-battling)
- ✅ Custom intro text before battle
- ✅ Trainer items (potions, revives, etc.)
- ✅ Pokemon with custom moves, abilities, items, gender
- ✅ Integrated with Essentials' battle system

## 🎯 Control Flow

### Conditionals

```
# Switch condition
CONDITIONAL: SWITCH 10 == ON
  TEXT: Switch 10 is on!
CONDITIONAL: ELSE
  TEXT: Switch 10 is off!

# Variable condition
CONDITIONAL: VARIABLE 5 >= 10
  TEXT: Variable is at least 10

# Choice condition
CONDITIONAL: CHOICE == 0
  TEXT: First option chosen
```

### Loops & Labels

```
# Label/Jump loop
VARIABLE: 10, = 0
LABEL: CountLoop
TEXT: Count: \v[10]
VARIABLE: 10, + 1
CONDITIONAL: VARIABLE 10 < 5
  JUMP_TO_LABEL: CountLoop

# Infinite loop with break
LOOP_START
  TEXT: Press button to continue
  BREAK_LOOP
LOOP_END
```

### Control Commands

```
EXIT_EVENT               # Stop event execution
ERASE_EVENT             # Erase this event permanently
CALL_COMMON_EVENT: 1    # Call common event #1
COMMENT: Dev note here  # Add comment (invisible in game)
```

## 🎛️ Game State Commands

### Switches & Variables

```
SWITCH: 10, ON                    # Turn switch 10 ON
SWITCH: 20, OFF                   # Turn switch 20 OFF
SELF_SWITCH: A, ON                # Turn self switch A ON
VARIABLE: 5, = 100                # Set variable 5 to 100
VARIABLE: 5, + 10                 # Add 10 to variable 5
VARIABLE: 5, - 5                  # Subtract 5 from variable 5
VARIABLE: 5, = VAR[10]            # Set variable 5 to value of variable 10
```

### Items, Money & Pokemon

```
ITEM: POTION, 5                   # Give 5 Potions
POKEMON: PIKACHU, 25              # Give level 25 Pikachu
CHANGE_GOLD: +1000                # Add 1000 gold
CHANGE_GOLD: -500                 # Remove 500 gold
CHANGE_ITEMS: 1, +5               # Add 5 of item ID 1
CHANGE_ITEMS: 2, -3               # Remove 3 of item ID 2
CHANGE_PARTY: 1, ADD              # Add actor 1 to party
CHANGE_PARTY: 2, REMOVE           # Remove actor 2 from party
```

## 🚶 Movement & Transfer

### Player Transfer

```
TRANSFER: 2, 10, 15, Down
```

**Format:** `map_id, x, y, direction`

### 🎬 Move Routes

```
SET_MOVE_ROUTE: PLAYER, THROUGH_ON, MOVE_UP, MOVE_UP, THROUGH_OFF
SET_MOVE_ROUTE: 0, TURN_LEFT, TURN_RIGHT, TURN_UP
WAIT_FOR_MOVE
```

**Target:**

- `PLAYER` = Player character
- `0` = This event
- `5` = Event ID 5

#### Movement Commands (40+ available!)

**Basic Movement:**

- `MOVE_DOWN`, `MOVE_LEFT`, `MOVE_RIGHT`, `MOVE_UP`
- `MOVE_LOWER_LEFT`, `MOVE_LOWER_RIGHT`
- `MOVE_UPPER_LEFT`, `MOVE_UPPER_RIGHT`
- `MOVE_RANDOM`
- `MOVE_TOWARD_PLAYER`, `MOVE_AWAY_FROM_PLAYER`
- `STEP_FORWARD`, `STEP_BACKWARD`

**Turning:**

- `TURN_DOWN`, `TURN_LEFT`, `TURN_RIGHT`, `TURN_UP`
- `TURN_90_RIGHT`, `TURN_90_LEFT`, `TURN_180`
- `TURN_90_RIGHT_OR_LEFT`, `TURN_RANDOM`
- `TURN_TOWARD_PLAYER`, `TURN_AWAY_FROM_PLAYER`

**Animation Options:**

- `MOVE_ANIMATION_ON/OFF` - Walking animation
- `STOP_ANIMATION_ON/OFF` - Stepping animation while stopped
- `DIRECTION_FIX_ON/OFF` - Lock facing direction
- `THROUGH_ON/OFF` - Walk through solid tiles
- `ALWAYS_ON_TOP_ON/OFF` - Display above other events

### Set Event Position

```
SET_EVENT_LOCATION: 5, 20, 15
```

**Format:** `event_id, x, y`

## 🎨 Screen Effects

### Fading

```
FADEOUT               # Fade to black
WAIT: 20             # Wait 20 frames
TRANSFER: 2, 10, 10, Down
FADEIN               # Fade in from black
```

### Screen Tone (Color Tint)

```
CHANGE_SCREEN_TONE: -255, -255, -255, 0, 20
```

**Format:** `red, green, blue, gray, duration`

- Values: -255 to +255
- Negative = darker, Positive = brighter
- Duration in frames (60 = 1 second)

**Examples:**

```
CHANGE_SCREEN_TONE: -255, -255, -255, 0, 30    # Fade to black
CHANGE_SCREEN_TONE: 0, 0, 0, 0, 30             # Back to normal
CHANGE_SCREEN_TONE: 0, 0, -100, 0, 20          # Blue tint (night)
CHANGE_SCREEN_TONE: 100, 50, 0, 0, 20          # Orange tint (sunset)
```

### Screen Flash

```
SCREEN_FLASH: 255, 0, 0, 255, 20
```

**Format:** `red, green, blue, alpha, duration`

- Values: 0-255
- Alpha: 0 = invisible, 255 = solid

### Screen Shake

```
SCREEN_SHAKE: 5, 5, 30
```

**Format:** `power, speed, duration`

### Player Transparency

```
CHANGE_TRANSPARENT: ON     # Make player invisible
CHANGE_TRANSPARENT: OFF    # Make player visible
```

## 🔊 Sound Effects

```
PLAY_SE: Door exit
PLAY_SE: Battle damage
PLAY_BGM: Route 1
PLAY_ME: Victory
```

Sound files must exist in Audio/SE, Audio/BGM, or Audio/ME folders.

## 🖼️ Pictures

```
SHOW_PICTURE: 1, picture1, 100, 100    # Show picture 1 at (100,100)
MOVE_PICTURE: 1, 200, 200              # Move picture 1 to (200,200)
ERASE_PICTURE: 1                       # Erase picture 1
```

**Format:** `picture_number (1-20), filename, x, y`

## ⏱️ Timing

```
WAIT: 30              # Wait 30 frames
WAIT: 60              # Wait 60 frames = 1 second
WAIT_FOR_MOVE         # Wait until move route completes
```

## 🔧 Menu & System

```
CHANGE_MENU_ACCESS: DISABLE        # Disable menu access
CHANGE_MENU_ACCESS: ENABLE         # Enable menu access
CHANGE_SAVE_ACCESS: DISABLE        # Disable saving
CHANGE_SAVE_ACCESS: ENABLE         # Enable saving
CHANGE_ENCOUNTER: DISABLE          # Disable wild encounters
CHANGE_ENCOUNTER: ENABLE           # Enable wild encounters
```

## 📚 Complete Examples

### Example 1: Simple Door Event

```
EVENT: House Door, X: 10, Y: 5
GRAPHIC: doors5
TRIGGER: Touch
SET_MOVE_ROUTE: PLAYER, THROUGH_ON, MOVE_UP, THROUGH_OFF
WAIT_FOR_MOVE
PLAY_SE: Door exit
FADEOUT
WAIT: 10
TRANSFER: 2, 15, 20, Down
FADEIN
```

### Example 2: Quest NPC (3 Pages)

```
EVENT: Quest Giver, X: 12, Y: 7
GRAPHIC: NPC 04
TRIGGER: Action
TEXT: Hello! I need help finding my Pokemon.
CHOICE: I'll help!, Maybe later
CONDITIONAL: CHOICE == 0
  TEXT: Thank you so much!
  TEXT: I think it went to Route 1.
  SWITCH: 50, ON
  SELF_SWITCH: A, ON
CONDITIONAL: ELSE
  TEXT: Please come back if you change your mind.

NEW_PAGE
GRAPHIC: NPC 04
CONDITION_SELF_SWITCH: A
CONDITION_SWITCH: 50, ON
TEXT: Did you find my Pokemon?
CHOICE: Yes! Here it is., Still looking...
CONDITIONAL: CHOICE == 0
  TEXT: Oh wonderful! Thank you!
  TEXT: Please take this as a reward.
  ITEM: POTION, 5
  CHANGE_GOLD: +1000
  POKEMON: EEVEE, 10
  SELF_SWITCH: B, ON
  SWITCH: 50, OFF
CONDITIONAL: ELSE
  TEXT: Please keep looking!

NEW_PAGE
GRAPHIC: NPC 04
CONDITION_SELF_SWITCH: B
TEXT: Thanks again for your help!
TEXT: We're so happy together now.
```

### Example 3: Treasure Chest

```
EVENT: Treasure Chest, X: 15, Y: 10
GRAPHIC: chest1
TRIGGER: Action
CONDITIONAL: SWITCH 60 == OFF
  TEXT: You found a treasure chest!
  PLAY_SE: Item get
  TEXT: Obtained 1000 gold and 3 Rare Candies!
  CHANGE_GOLD: +1000
  ITEM: RARE_CANDY, 3
  SWITCH: 60, ON
  SELF_SWITCH: A, ON
CONDITIONAL: ELSE
  TEXT: The chest is empty.

NEW_PAGE
GRAPHIC: chest1, 1
CONDITION_SELF_SWITCH: A
TRIGGER: Action
TEXT: The chest is empty.
```

### Example 4: Healing Station

```
EVENT: Healing Station, X: 20, Y: 8
GRAPHIC: healingmachine
TRIGGER: Action
TEXT: Welcome to the Healing Station!
TEXT: Let me heal your Pokemon.
PLAY_SE: Pkmn heal
FADEOUT
WAIT: 20
SCRIPT: pbHealAll
FADEIN
TEXT: Your Pokemon are fully healed!
TEXT: Come back anytime!
```

### Example 5: Spinning NPC

```
EVENT: Dizzy Guy, X: 18, Y: 12
GRAPHIC: NPC 05
TRIGGER: Action
TEXT: Watch me spin!
SET_MOVE_ROUTE: 0, TURN_RIGHT, TURN_DOWN, TURN_LEFT, TURN_UP
WAIT_FOR_MOVE
SET_MOVE_ROUTE: 0, TURN_RIGHT, TURN_DOWN, TURN_LEFT, TURN_UP
WAIT_FOR_MOVE
TEXT: I'm so dizzy now!
```

## 🐛 Debugging

### Debug Menu (F9)

1. **Import Events Now** - Manually trigger import
2. **Clear Imported Events** - Remove all imported events from Map 003

### Console Output

The plugin shows detailed output during startup:

```
Importing events from: test_simple.txt
Processing map 3
Parsing line: EVENT: Simple NPC, X: 10, Y: 5
Event has 1 page(s)
Added event: Simple NPC at (10, 5)
```

## 💡 Tips & Best Practices

1. **No Empty Lines** - Don't put empty lines within event definitions (they mark the end)
2. **Test Incrementally** - Start with simple events, add complexity gradually
3. **Use Comments** - Add `COMMENT:` lines for documentation
4. **Backup Maps** - Always backup Data/MapXXX.rxdata before importing
5. **Check with Exporter** - Use Event Exporter plugin to verify event structure
6. **Consistent IDs** - Use the same switch/variable IDs across related events
7. **Self Switches** - Best for simple per-event state (A, B, C, D)
8. **Regular Switches** - Best for global game state
9. **Variables** - Good for counters, timers, progression tracking

## ⚠️ Known Limitations

**Not Yet Implemented:**

- Jump commands with X/Y parameters in move routes
- Graphic changes during move routes
- SE/Script commands in move routes
- Wait commands in move routes
- Complex page graphic patterns

**Text Formatting:**

- Use `\v[n]` for variables in text
- Use `\n[n]` for actor names in text
- Some special characters may need escaping

## 📜 Changelog

### Version 1.3 - Complete Edition

- **🔧 MAJOR FIX:** Corrected all Move Command codes (they were completely wrong!)
  - `MOVE_UP` was 1, now correctly 4
  - `THROUGH_ON` was 42, now correctly 37
  - All 40+ move commands now have correct codes
- ✅ SET_MOVE_ROUTE fully working and Event Exporter compatible
- ✅ Added DIRECTION property for events
- ✅ Fixed SCREEN_FLASH to use Color (was incorrectly using Tone)
- ✅ Added 35 movement commands
- ✅ Full compatibility with RMXP Event Exporter verified

### Version 1.2

- Added 50+ RMXP event commands
- Added CHANGE_SCREEN_TONE for color tinting
- Added screen effects (shake, flash, fade)
- Added picture commands (show, move, erase)
- Added gold/items/party management commands
- Added menu/system access controls

### Version 1.1

- Added multiple event pages (NEW_PAGE)
- Added page conditions (switch, self switch, variable)
- Added self switches (A, B, C, D)
- Added variable operations
- Added item and Pokemon commands
- Added choices and conditionals

### Version 1.0

- Initial release
- Basic event creation from text files
- TEXT, SCRIPT, SWITCH commands
- GRAPHIC, TRIGGER properties
- Debug menu integration

## 📖 More Examples

See `EventImporter/advanced_examples.txt.bak` for **15 complex example events** including:

- Multi-page quest NPCs
- Door events with followers
- Treasure chests with state
- Weather control systems
- Shop NPCs
- Trainer battles
- Picture galleries
- Counter/loop demonstrations
- Screen effect showcases
- And more!

Rename the file to `.txt` to import them all!

## 🎓 Credits

**Created for:** Pokemon Essentials v21.1  
**Compatible with:** RMXP Event Exporter plugin  
**Version:** 1.3

---

**Happy Event Creating!** 🎮✨

_Questions? Issues? Check the examples or create detailed events step-by-step!_


---

## Regicode

**Name**: 

**Version**: 1.0

**Author**: 

**Files**: 1 Ruby files


---

## SwSh Berry Tree

**Name**: Berry Tree

**Version**: 1.0.0

**Author**: 

**Files**: 2 Ruby files


---

## TDW Berry Planting Improvements

**Name**: TDW Berry Planting Improvements

**Version**: 1.9.5

**Author**: 

**Files**: 6 Ruby files


---

## Tileset Rearranger

**Name**: 

**Version**: 1.4

**Author**: 

**Link**: https://reliccastle.com/resources/794/

**Files**: 7 Ruby files


---

## Time-Based Fishing Encounters

**Name**: Time-Based Fishing Encounters

**Version**: 1.0.0

**Author**: 

**Link**: no link

**Files**: 3 Ruby files


---

## Trade Expert

**Name**: Trade Expert

**Version**: 1.2

**Author**: 

**Dependencies**:
- Luka's Scripting Utilities
- 3.2

**Files**: 2 Ruby files


---

## Tutor.net

**Name**: 

**Version**: 1.2.3

**Author**: 

**Files**: 3 Ruby files


---

## Type Icons in Battle

**Name**: Type Icons in Battle

**Version**: 1.0.0

**Author**: 

**Files**: 1 Ruby files


---

## UTS

**Name**: UTS

**Version**: 1.0

**Author**: 

**Files**: 1 Ruby files


---

## Voltseon's Pause Menu

**Name**: N/A

**Version**: 2.2

**Author**: 

**Files**: 6 Ruby files


---

## [000] Marshal Compatibility

**Files**: 1 Ruby files


---

## [000_AAI] Advanced AI System

**Name**: Advanced AI System

**Version**: 1.0.0

**Author**: 

**Dependencies**:
- Challenge Modes

**Files**: 21 Ruby files

### Description

# Advanced AI System v3.0.0 (Reborn-Inspired)

**Master-Tier Pokémon-KI für Hardmode-Spieler**

Ein umfassendes KI-System für Pokémon Essentials v21.1, inspiriert von **Pokémon Reborn**, das Computer-Gegner dramatisch verbessert durch:
- **Move Memory System**: Trackt alle Gegner-Züge für intelligente Vorhersagen
- **Threat Assessment**: 10-Punkte-Skala Gefahrenbewertung (Stats, Moves, Abilities)
- **Switch-In Logik**: Intelligente Wechsel basierend auf Typ-Matchups, Rollen und Momentum
- **Role Detection**: 7 Pokemon-Rollen (Sweeper, Wall, Tank, Support, Wallbreaker, Pivot, Lead)
- **Field Effects**: Wetter, Terrain, Trick Room Awareness
- **Doubles Coordination**: Partner-Synergie, Overkill-Prevention, Spread Move Optimization
- **267+ Gen 1-9 Abilities**: Vollständige Ability-Analyse für Threat Assessment
- **900+ Move Categories**: Automatische Move-Kategorisierung (Priority, Setup, Hazards, etc.)
- **693 Items**: Intelligente Item-Nutzung (Choice items, Life Orb, Assault Vest, etc.)
- **Setup Recognition**: 5 Bewertungs-Systeme für Setup-Counter
- **Endgame Logic**: Spezielle 1v1/2v2 Strategien
- **Battle Personalities**: 4 verschiedene Spielstile (Aggressive, Defensive, Balanced, Hyper Offensive)
- **Prediction System**: Switch & Move Prediction basierend auf Patterns
- **Team Preview**: Optimale Lead-Auswahl basierend auf Matchups
- **18 verbundene Systeme**: Über 15.000 Codezeilen Master-Level-Intelligenz
- **Volle DBK-Kompatibilität**: Dynamax, Terastallization, Z-Moves, Raid Battles
- **Generation 9 Support**: Kompatibel mit Gen 9 Pack

---

## 🚀 Schnellstart

### Installation

1. Kopiere `[AAI_000] Advanced AI System` nach `Plugins/`
2. Das Plugin aktiviert sich automatisch (siehe Einstellungen)
3. Starte das Spiel - KI ist sofort verbessert!

### Basis-Konfiguration

```ruby
# In [001] Settings.rb
module AdvancedAI
  ENABLED = true                           # System an/aus
  MIN_SKILL_FOR_AUTO_ACTIVATION = 70      # Auto-Aktivierung ab Skill 70
  DEBUG_MODE = false                       # Debug-Logging
end
```

### Testen

```ruby
# Trainer mit Master-KI erstellen
pbTrainerBattle(:POKEMONTRAINER_Red, "Red", nil, false, 0, true, 100)
# Skill 100 = Alle Features inkl. Tera
```

---

## 🎯 Feature-Übersicht

### Kern-Systeme (Skill 50+) - Reborn-Inspired

**1. Settings & Core** ([001]-[002])
- Konfigurations-Management
- Skill-Level-System
- Challenge Mode Integration

**2. Move Scoring** ([003])
- 20+ Bewertungsfaktoren
- Schadens-Berechnung
- KO-Prediction

**3. Move Memory** ([007]) ⭐
- **Trackt alle Gegner-Moves**
- **Priority Move Detection**
- **Healing Move Detection**
- **Max Damage Calculation**
- **Move Frequency Tracking**

**4. Threat Assessment** ([008]) ⭐
- **10-Punkte-Skala** (0 = harmlos, 10 = extrem gefährlich)
- **Stat-basierte Bedrohung** (Atk/SpAtk vs Def/SpDef)
- **Typ-Matchup Bedrohung** (SE/NVE/Immune)
- **Move-basierte Bedrohung** (Priority, OHKO, Setup)
- **Ability-basierte Bedrohung** (Huge Power, Adaptability, etc.)
- **HP-Modifier** (schwache Gegner = niedrigere Bedrohung)
- **Setup-Bedrohung** (Stat Boosts erhöhen Gefahr)
- **Speed-Bedrohung** (schnellere Gegner = gefährlicher)

**5. Doubles Coordination** ([009]) ⭐
- **Overkill-Prevention** (-40 wenn Partner auch angreift)
- **Move Conflict Prevention** (kein doppeltes Screens/Hazards)
- **Spread Move Optimization** (EQ mit Levitate Partner)
- **Field Effect Coordination** (Weather für Partner-Ability)
- **Protect + Setup Combos** (Partner setuppt → Protect)

**6. Field Effects** ([010]) ⭐
- **Weather Awareness** (Rain +30 für Water, Sun +30 für Fire)
- **Terrain Awareness** (Electric Terrain +25, Grassy -20 für EQ)
- **Trick Room Logic** (bevorzugt langsame Pokemon)
- **Gravity Synergy** (Ground trifft Flying, OHKO 100% acc)
- **Room Effects** (Magic Room, Wonder Room)

**7. Role Detection** ([011]) ⭐
- **7 Pokemon-Rollen**:
  - Sweeper (Speed 100+, Atk/SpAtk 100+)
  - Wall (HP/Def/SpDef 300+, Speed <70)
  - Tank (HP 90+, Atk/SpAtk 100+, Speed <90)
  - Support (Screens, Hazards, Status moves)
  - Wallbreaker (Atk/SpAtk 120+)
  - Pivot (U-turn, Volt Switch, Flip Turn)
  - Lead (Hazard setter, Fast Taunt)
- **Counter-Play**: Wall → Wallbreaker, Sweeper → Wall
- **Best Pokemon für Rolle finden**

**8. Switch Intelligence** ([012]) ⭐
- **Typ-Matchup Analyse** (40 Punkte)
- **HP & Status Analyse** (30 Punkte)
- **Stat Stage Analyse** (25 Punkte)
- **Bessere Optionen** (35 Punkte)
- **Momentum Kontrolle** (20 Punkte)
- **Vorhersage-Bonus** (15 Punkte)
- **Rollen-basiertes Switching** (empfiehlt Counter-Rolle)

### DBK-Integration (Skill 95-100+)

**4. Dynamax Intelligence** ([022]) - **DBK_005**
- 6 Bewertungs-Systeme
- Strategisches Timing
- G-Max-Attacken-Optimierung
- HP-Boost-Analyse

**5. Terastallization Intelligence** ([023]) - **DBK_006**
- 6 Bewertungs-Systeme
- Typ-Vorteil-Analyse
- Sweep-Potential-Erkennung
- Survival-Necessity-Bewertung

---

## 🧠 Switch Intelligence - Herzstück

Die **Switch Intelligence** ist das Herzstück für Hardmode-Spieler:

### Wann wechselt die KI?

```
SWITCH SCORE = Typ-Nachteil + HP-Probleme + Stat-Senkungen + 
               Bessere Option - Momentum-Verlust - Setup-Verschwendung

Schwellenwerte:
Master  (Skill 100): 35+ Punkte → Switch
Expert  (Skill 90):  40+ Punkte → Switch
Advanced(Skill 80):  45+ Punkte → Switch
Core    (Skill 50):  50+ Punkte → Switch
```

### Evaluierungs-Faktoren

**1. Typ-Matchup (0-40 Punkte)**
```ruby
# Gegner hat sehr effektive Attacke → +15
# User trifft nicht sehr effektiv → +10
# Gegner hat STAB + super effective → +15
# Total: Bis zu 40 Punkte
```

**2. Überlebens-Bedenken (0-30 Punkte)**
```ruby
# HP < 25% → +30
# HP < 40% → +20
# HP < 55% → +10
# Keine Heilung + niedrige HP → +10
# Toxisch vergiftet → +20
# OHKO-Gefahr → +15
```

**3. Stat-Stages (0-25 Punkte)**
```ruby
# -1 Stat Stage → +8 pro Stage
# -2 Angriff (physical attacker) → +10
# -2 Speed → +12
# Gegner mit +4 Boosts → +10
```

**4. Bessere Option (0-35 Punkte)**
```ruby
# Deutlich besseres Matchup verfügbar → +35
# Gutes Matchup verfügbar → +25
# Leichtes Matchup → +15
```

**5. Momentum (0-20 Punkte)**
```ruby
# Team im Nachteil → +10
# Gegner will Setup → +15
```

**Malus-Faktoren:**
```ruby
# User hat Vorteil → -20
# User hat +2 Boosts → -20
# User hat +4 Boosts → -30
```

---

## 📊 Skill-Level-System

```
SKILL LEVEL → FEATURES

50+  → Kern-KI (Move Scoring, Threat Assessment, Switch Intelligence)
55+  → + Setup Recognition
60+  → + Endgame Scenarios
65+  → + Battle Personalities
85+  → + Item Intelligence + Prediction System
90+  → + Team Preview Intelligence
95+  → + Dynamax Intelligence (DBK_005)
100+ → + Terastallization (DBK_006) [MASTER-TIER]
```

### Empfohlene Skill-Level

```
Route-Trainer:      50-55  (Kern-KI)
Arena-Leiter:       60-75  (+ Setup & Endgame)
Top Vier:           80-90  (+ Items & Vorhersage)
Champion/Bosse:     95-100 (Alle Features)
Post-Game-Bosse:    100+   (Master-Tier mit Tera)
```

---

## 🎮 Verwendung

### Trainer-Definition

```ruby
# Standard-Trainer (Basic AI)
pbTrainerBattle(:YOUNGSTER, "Joey", nil, false, 0, true, 45)

# Kern-AI (Switch Intelligence aktiv)
pbTrainerBattle(:LEADER_Brock, "Rocko", nil, false, 0, true, 65)

# Experten-AI (Items + Prediction)
pbTrainerBattle(:LEADER_Giovanni, "Giovanni", nil, false, 0, true, 85)

# Master-AI (Dynamax Intelligence)
pbTrainerBattle(:CHAMPION_Cynthia, "Cynthia", nil, false, 0, true, 95)

# Master-AI mit Tera (Alle Features)
pbTrainerBattle(:CHAMPION_Red, "Red", nil, false, 0, true, 100)
```

### Event-Skripte

```ruby
# Manuell aktivieren/deaktivieren
AdvancedAI.activate!
AdvancedAI.deactivate!

# Prüfen ob aktiv
if AdvancedAI.active?
  pbMessage("Bereite dich auf einen harten Kampf vor!")
end

# Feature-Check
if AdvancedAI.feature_enabled?(:terastallization, 100)
  pbMessage("Der Gegner kann Terastallisieren!")
end
```

---

## 🔧 Konfiguration

### Skill-Schwellenwerte anpassen

```ruby
# In [001] Settings.rb
SKILL_THRESHOLDS = {
  :core              => 40,   # Niedriger = früher aktiv
  :setup             => 50,
  :endgame           => 55,
  :personalities     => 60,
  :items             => 80,
  :prediction        => 80,
  :team_preview      => 85,
  :dynamax           => 90,
  :terastallization  => 95    # Niedriger für mehr Tera-KI
}
```

### Advanced Flags (Feintuning)

```ruby
# Bit-Flags für granulare Kontrolle
ADVANCED_FLAGS = {
  :switch_prediction    => 0b00000001,  # Gegner-Switch vorhersagen
  :setup_chains         => 0b00000010,  # Baton Pass Chains
  :hazard_calc          => 0b00000100,  # Entry Hazards
  :weather_abuse        => 0b00001000,  # Wetter ausnutzen
  :terrain_abuse        => 0b00010000,  # Terrain ausnutzen
  :ko_prediction        => 0b00100000,  # KO vorhersagen
  :revenge_kill         => 0b01000000,  # Revenge Kill verhindern
  :momentum_control     => 0b10000000   # Momentum kontrollieren
}

# Alle aktivieren
DEFAULT_FLAGS = 0b11111111
```

### Debug-Modus

```ruby
DEBUG_MODE = true  # Detailliertes Logging

# Console Output:
# [AI] Switch score for Pikachu: 45
# [Switch] Best switch: Index 2 with score 65
# [Dynamax] Dynamax score for Charizard: 85
# [Tera] Tera score for Garchomp: 72
```

---

## 🔌 Kompatibilität

### Erforderlich
- Pokémon Essentials v21.1+
- Ruby 3.1+

### DBK Plugin Integration

✅ **DBK_000** - Deluxe Battle Kit (Core)  
✅ **DBK_002** - SOS Battles  
✅ **DBK_003** - Raid Battles  
✅ **DBK_004** - Z-Power (Z-Moves)  
✅ **DBK_005** - Dynamax ⭐ (Skill 95+)  
✅ **DBK_006** - Terastallization ⭐ (Skill 100+)  
✅ **DBK_007** - Improved Item AI

### Andere Plugins

✅ Generation 9 Pack  
✅ Challenge Modes (Auto-Aktivierung)  
✅ Modular UI  
✅ Charms Compilation  
✅ Arcky's Region Map

**Keine bekannten Konflikte!**

---

## 📈 Performance

- **Move Scoring**: ~3-5ms pro Zug
- **Switch Analysis**: ~5-8ms pro Check
- **Dynamax/Tera**: ~2-4ms pro Bewertung
- **Gesamt**: <15ms pro Zug (nicht spürbar)

**Speicher**: ~100KB pro Kampf

---

## 🐛 Problembehandlung

### KI aktiviert sich nicht

```ruby
# Prüfe Einstellungen
AdvancedAI::ENABLED = true
MIN_SKILL_FOR_AUTO_ACTIVATION = 50  # Senken

# Manuell aktivieren
AdvancedAI.activate!
```

### Switch Intelligence funktioniert nicht

```ruby
# Prüfe Skill-Level
skill = 65  # Minimum für gute Switch-AI
pbTrainerBattle(:LEADER_Brock, "Rocko", nil, false, 0, true, skill)

# Debug aktivieren
DEBUG_MODE = true
# Schau in Console nach "[Switch]" Meldungen
```

### Dynamax/Tera funktioniert nicht

```ruby
# 1. Plugin installiert?
AdvancedAI.dbk_enabled?(:dynamax)       # → true?
AdvancedAI.dbk_enabled?(:terastallization)  # → true?

# 2. Skill-Level hoch genug?
skill = 95   # Für Dynamax
skill = 100  # Für Terastallization

# 3. Pokemon kann es nutzen?
battler.can_dynamax?  # → true?
battler.can_terastallize?  # → true?
```

---

## 📚 Entwickler-Referenz

### API-Methoden

```ruby
# System-Status
AdvancedAI.active?                        # → Boolean
AdvancedAI.qualifies_for_advanced_ai?(70) # → Boolean
AdvancedAI.get_ai_tier(100)               # → :master

# Feature-Checks
AdvancedAI.feature_enabled?(:dynamax, 95)      # → Boolean
AdvancedAI.dbk_enabled?(:terastallization)     # → Boolean

# Battle-Methoden
battle.uses_advanced_ai?(trainer_index)   # → Boolean

# Battler-Methoden
battler.ai_skill_level                    # → Integer (0-100+)
battler.ai_tier                           # → Symbol (:basic, :core, etc.)
```

### Eigene Systeme erweitern

```ruby
class Battle::AI
  # Custom Scoring Modifier
  def apply_custom_logic(score, move, user, target, skill)
    # Drachen-Bonus für Skill 100+
    if move.type == :DRAGON && skill >= 100
      score += 25
    end
    
    return score
  end
  
  # In [002] Core.rb einbinden:
  alias original_apply_advanced_modifiers apply_advanced_modifiers
  def apply_advanced_modifiers(score, move, user, target, skill)
    score = original_apply_advanced_modifiers(score, move, user, target, skill)
    score = apply_custom_logic(score, move, user, target, skill)
    return score
  end
end
```

---

## 📝 Was macht dieses System anders?

### 1. **Reborn-Inspired Move Memory** 🧠
- KI **trackt alle Spieler-Moves** permanent
- Nutzt Memory für Switch-Entscheidungen
- Erkennt Priority Moves → Protect-Timing
- Berechnet Max Damage → Überlebens-Kalkulation

### 2. **Intelligente Threat Assessment** ⚠️
- **10-Punkte-Skala** (0 = harmlos, 10 = tödlich)
- 8 Bewertungs-Faktoren (Stats, Typ, Moves, Ability, HP, Setup, Speed)
- Priorität-System für Doubles
- Switch bei threat > 7.0

### 3. **Role Detection System** 🎭
- **7 automatisch erkannte Rollen**
- Counter-Pick-Logik (Sweeper → Wall)
- Bestes Pokemon für Situation finden
- Rollen-basiertes Switching

### 4. **Doubles Coordination** 🤝
- Overkill-Prevention (kein Fokus auf schwache Ziele)
- Move Conflict Prevention (keine doppelten Screens)
- Spread Move Optimization (EQ mit Flying Partner)
- Protect + Setup Combos

### 5. **Field Effects Mastery** 🌦️
- Weather Awareness (+30 für passende Typen)
- Terrain Synergy (Grassy -20 für EQ)
- Trick Room Logic (bevorzugt langsame Pokemon)
- Ability-Weather-Synergien (Swift Swim + Rain)

### 6. **Echte Switch-In Logik** 🔄
- KI wechselt proaktiv bei schlechten Matchups
- Evaluiert 6+ Faktoren für Wechsel-Entscheidung
- Findet beste Switch-Option aus Team
- Berücksichtigt Entry Hazards
- **Rollen-basiertes Switching** (Counter-Picks)

### 7. **DBK-Integration** ⚡
- Nutzt Dynamax strategisch (nicht random)
- Terastallize für Survival oder Sweep
- Z-Moves zur richtigen Zeit
- Raid Battle Awareness

### 8. **Skill-basiert skalierbar** 📊
- Route-Trainer: Basic AI
- Arena-Leiter: Move Memory + Threat Assessment
- Top Vier: + Field Effects + Role Detection
- Champion: + Dynamax/Tera Mastery

### 9. **Performance-optimiert** ⚡
- Cached Berechnungen
- <20ms pro Zug
- Keine FPS-Drops
- Memory Cleanup nach Battle

---

## 👥 Credits

**Autor**: Marcel Weidenauer  
**Version**: 2.1.0  
**Datum**: Dezember 2024

**Inspiration**:
- Pokémon Essentials Team
- Radical Red AI
- Smogon Competitive Community

---

## 📜 Lizenz

Kostenlos für nicht-kommerzielle Pokémon Fan-Spiele.

**Rechte**:
- ✅ Nutzen in Fan-Games
- ✅ Modifizieren & Anpassen
- ✅ Teilen mit anderen
- ❌ Kommerzielle Nutzung (ohne Erlaubnis)

---

## 🔮 Implementierte Features (v3.0.0) - KOMPLETT!

### Core Systems (Skill 50+)
- [x] **[001] Settings** - Konfigurations-Management
- [x] **[002] Core** - Basis-Integration mit Essentials v21.1
- [x] **[003] Move_Scorer** - Intelligente Attacken-Bewertung

### Reborn-Inspired Systems ⭐
- [x] **[007] Move_Memory** - Trackt alle Gegner-Moves permanent
- [x] **[008] Threat_Assessment** - 10-Punkte-Skala Gefahrenbewertung
- [x] **[009] Doubles_Coordination** - Partner-Synergie & Overkill-Prevention
- [x] **[010] Field_Effects** - Wetter, Terrain, Trick Room Awareness
- [x] **[011] Role_Detection** - 7 Pokemon-Rollen erkennen
- [x] **[012] Switch_Intelligence** - 6 Faktoren + Rollen-basierte Logik

### Advanced Content (Skill 55-85+)
- [x] **[013] Custom_Content** - 267 Gen 1-9 Abilities analysiert
- [x] **[014] Move_Categories** - 900+ kategorisierte Moves
- [x] **[015] Item_Intelligence** - 693 Items analysiert
- [x] **[016] Prediction_System** - Switch & Move Prediction
- [x] **[017] Team_Preview** - Optimale Lead-Auswahl
- [x] **[019] Setup_Recognition** - 5 Bewertungs-Systeme
- [x] **[020] Endgame_Scenarios** - 1v1/2v2 Spezial-Logik
- [x] **[021] Battle_Personalities** - 4 Spielstile

### DBK Integration (Skill 95-100+)
- [x] **[022] Dynamax_Intelligence** - DBK_005 Integration
- [x] **[023] Terastallization_Intelligence** - DBK_006 Integration

---

**🎉 v3.0.0 = VOLLSTÄNDIG! Alle 18 Module implementiert!**

**Stats:**
- 18 Module
- ~15.000 Codezeilen
- 267 Abilities
- 900+ Moves kategorisiert
- 693 Items analysiert
- 7 Pokemon-Rollen
- 4 Battle-Personalities
- 5 Setup-Counter-Systeme

---

**Advanced AI System v3.0.0 - Master-Tier Intelligence with Full Gen 9 Support**

Made with ❤️ for Hardmode Players | Inspired by Pokémon Reborn

**🌟 Key Features:**
- Move Memory System (trackt alle Gegner-Züge)
- Threat Assessment (10-Punkte-Skala mit 8 Faktoren)
- Role Detection (7 Rollen mit Counter-Picks)
- Doubles Coordination (4 Prevention-Systeme)
- Field Effects Mastery (Weather/Terrain/Rooms)
- 267 Gen 1-9 Abilities analysiert
- 900+ Move Categories
- 693 Items Intelligence
- Setup Recognition (5 Systeme)
- Endgame Logic (1v1/2v2)
- Battle Personalities (4 Spielstile)
- Prediction System (Switch/Move)
- Team Preview Intelligence
- DBK Integration (Dynamax/Tera)


---

## [005] Dynamic Lighting System

**Name**: Dynamic Lighting System

**Version**: 1.0

**Author**: 

**Link**: no

**Files**: 6 Ruby files


---

## [006] Chimney Smoke System

**Name**: Chimney Smoke System

**Version**: 1.0

**Author**: 

**Link**: no

**Files**: 5 Ruby files

### Description

# Chimney Smoke System

Ein System für animierten Schornstein-Rauch in Pokémon Essentials v21.1.

## Features

- ✅ Präzise Pixel-Positionierung (keine Tile-Begrenzung)
- ✅ Animierte Character-Grafiken
- ✅ Tag/Nacht-System Integration (Rauch nur am Tag)
- ✅ Automatische Aktualisierung bei Zeitwechsel
- ✅ Einfache Definition via Code
- ✅ Debug-Tools zum Testen

## Installation

1. Copy the `[006] Chimney Smoke System` folder to `Plugins/`
2. Create a wind graphic in `Graphics/Characters/` (e.g. `wind_leaves.png`)
3. Define your wind effects in `[004] Wind_Definitions.rb`

## Wind Graphic Format

The graphic should be in character format:

- 4 columns (animations: 0-3)
- 4 rows (directions: Down, Left, Right, Up)
- Recommended size: 128x128 pixels (32x32 per frame)

## Usage

### Add Wind Effect

Edit `[004] Wind_Definitions.rb`:

```ruby
pbAddWindEffect(:wind_leaves, 100, 200, "wind_leaves", 2, :left)
```

### Parameters

- **id**: Unique symbol ID (e.g. `:wind1`)
- **x**: Pixel X position
- **y**: Pixel Y position
- **bitmap_path**: Filename of the graphic (without .png)
- **wind_strength**: 1, 2, or 3 (affects animation speed)
- **direction**: `:left` for right-to-left animation

### Remove Wind Effect

```ruby
pbRemoveWindEffect(:wind_leaves)
```

- `:direction` - 2=unten, 4=links, 6=rechts, 8=oben
- `:speed` - Animationsgeschwindigkeit (FPS)
- `:opacity` - Deckkraft (0-255)

## Position finden

### Methode 1: Debug-Befehl

1. Drücke **Strg+Shift+P** im Spiel
2. Die aktuelle Pixel-Position wird angezeigt
3. Verwende diese Werte für `x` und `y`

### Methode 2: Von Tile-Koordinaten

- X (Pixel) = Tile-X × 32
- Y (Pixel) = Tile-Y × 32

Beispiel: Tile (8, 16)

- X = 8 × 32 = 256
- Y = 16 × 32 = 512

### Position anpassen

- Um nach **rechts** zu verschieben: X erhöhen (z.B. +4)
- Um nach **links** zu verschieben: X verringern (z.B. -4)
- Um nach **unten** zu verschieben: Y erhöhen
- Um nach **oben** zu verschieben: Y verringern

## Debug-Befehle

- **Strg+Shift+C**: Zeigt alle Rauch-Effekte auf der aktuellen Map
- **Strg+Shift+P**: Zeigt die aktuelle Spieler-Position in Pixeln

## Integration mit Dynamic Lighting System

Das System erkennt automatisch das Night Tileset System und aktualisiert sich bei Zeitänderungen. Falls nicht installiert, verwendet es einen eigenen Day/Night-Tracker.

## Beispiel: Purple House auf Map 43

```ruby
# Event war bei Tile (8, 16) = Pixel (256, 512)
# Rauch war zu weit links, daher +4 auf X
pbAddChimneySmoke(:purple_house_smoke, 43, 260, 512, "smoke", true)
```

## Troubleshooting

**Rauch wird nicht angezeigt:**

- Prüfe, ob die Grafik in `Graphics/Characters/` existiert
- Verwende **Strg+Shift+C** für Debug-Info
- Stelle sicher, dass es Tag ist (wenn `day_only: true`)

**Rauch ist falsch positioniert:**

- Verwende **Strg+Shift+P** um die richtige Position zu finden
- Passe X/Y Werte in kleinen Schritten an (±2-4 Pixel)

**Rauch verschwindet nicht nachts:**

- Setze `day_only: true` in der Definition
- Teste mit **Strg+Shift+C** ob die Sichtbarkeit korrekt ist


---

## [007] Wind Animation System

**Name**: Wind Animation System

**Version**: 1.0

**Author**: 

**Link**: no

**Files**: 1 Ruby files


---

## [DBK_000] Deluxe Battle Kit

**Name**: Deluxe Battle Kit

**Version**: 1.2.9

**Author**: 

**Dependencies**:
- v21.1 Hotfixes
- 1.0.9

**Files**: 23 Ruby files


---

## [DBK_001] Enhanced Battle UI

**Name**: [DBK] Enhanced Battle UI

**Version**: 2.0.9

**Author**: 

**Dependencies**:
- Deluxe Battle Kit
- 1.2.8

**Files**: 6 Ruby files


---

## [DBK_002] SOS Battles

**Name**: 

**Version**: 1.1.1

**Author**: 

**Dependencies**:
- Deluxe Battle Kit
- 1.2.7

**Files**: 8 Ruby files


---

## [DBK_003.1] Raid Battles Hotfixes

**Name**: Raid Battles Hotfixes

**Version**: 1.0.7

**Author**: 

**Dependencies**:
- [DBK] Raid Battles
- 1.0

**Files**: 12 Ruby files

### Changelog

# Raid Battles Hotfixes - Changelog

## Version 1.0.5 (2025-10-17)

### Bug Fixes

#### [012] Ultra Adventure Z-Crystal Fix

- **Fixed**: Rare crash in Ultra Raids/Adventures when Pokémon load without a Z-Crystal
- **Fixed**: Random crashes when battling raid Pokémon in Ultra Adventures
- **Root Cause**:
  - Race condition where cloned Pokémon objects lose their Z-Crystal item during the cloning process
  - Missing `editWildPokemon` battle rule initialization before cloning raid Pokémon
  - Z-Crystal assignment logic could be skipped when `editedPkmn` conditions weren't met
  - The bug was intermittent because it depended on the state of battle rules at the moment of cloning
- **Solution**:
  - **Multiple Safety Layers**: Added three layers of Z-Crystal verification:
    1. Post-attribute check in `setRaidBossAttributes` to ensure Z-Crystals are assigned after all setup
    2. Pre-battle verification when cloning Pokémon in adventure battle tiles
    3. Post-generation check in `generate_raid_foe` for Ultra style raids
  - **Battle Rule Initialization**: Ensures `editWildPokemon` rule exists before cloning to prevent nil errors
  - **Debug Logging**: Added optional debug messages (when `RAID_BATTLE_DEBUG` is enabled) to track Z-Crystal assignments
  - All checks verify: Pokemon doesn't have Z-Crystal, isn't Ultra form, and doesn't have any item before assigning

---

## Version 1.0.4 (2025-10-13)

### Bug Fixes

#### [008] Ditto Raid Fix (Extended)

- **Fixed**: Ditto in Tera Raids using Struggle (no compatible moves)
- **Fixed**: Wobbuffet and other Pokémon without damaging moves in raids
- **Fixed**: Ditto causing `baseMoves` error during raid battles
- **Root Cause**:
  - Ditto only learns Transform, which cannot be Tera-typed
  - Some Pokémon lack damaging moves matching raid requirements
  - The `baseMoves` attribute may not exist for transformed Pokémon
- **Solution**:
  - **Moveset Failsafe System**: Automatically assigns appropriate moves when no viable moves are found:
    - **Tera Raids**: Tera Blast (works with any Tera type)
    - **Ultra/Max Raids**: Type-appropriate powerful moves (e.g., Flamethrower for Fire-types)
    - **Basic Raids**: Universal moves (Tackle, Body Slam, etc.)
  - **Shield Damage Fix**: Added safety checks for `baseMoves` attribute in Ultra and Max raid styles
  - Applies to all Pokémon with empty or non-damaging movesets

---

## Version 1.0.3


---

## [DBK_003] Raid Battles

**Name**: 

**Version**: 1.0

**Author**: 

**Dependencies**:
- Deluxe Battle Kit
- 1.2.9

**Files**: 42 Ruby files


---

## [DBK_004] Z-Power

**Name**: [DBK] Z-Power

**Version**: 1.1.1

**Author**: 

**Dependencies**:
- Deluxe Battle Kit
- 1.2.7

**Files**: 11 Ruby files


---

## [DBK_005] Dynamax

**Name**: [DBK] Dynamax

**Version**: 1.1.3

**Author**: 

**Dependencies**:
- Deluxe Battle Kit
- 1.2.9

**Files**: 18 Ruby files


---

## [DBK_006] Terastallization

**Name**: [DBK] Terastallization

**Version**: 1.1.5

**Author**: 

**Dependencies**:
- Deluxe Battle Kit
- 1.2.7

**Files**: 12 Ruby files


---

## [DBK_007] Improved Item AI

**Name**: [DBK] Improved Item AI

**Version**: 1.0.2

**Author**: 

**Dependencies**:
- Deluxe Battle Kit
- 1.2.9

**Files**: 5 Ruby files


---

## [DBK_009] Animated Pokemon System

**Name**: [DBK] Animated Pokémon System

**Version**: 1.1.1

**Author**: 

**Dependencies**:
- Deluxe Battle Kit
- 1.2.8

**Files**: 11 Ruby files


---

## [DBK_010] Animated Trainer Intros

**Name**: [DBK] Animated Trainer Intros

**Version**: 1.0.1

**Author**: 

**Dependencies**:
- Deluxe Battle Kit
- 1.2.7

**Files**: 8 Ruby files


---

## [MUI_000] Modular UI Scenes

**Name**: 

**Version**: 2.0.9

**Author**: 

**Dependencies**:
- v21.1 Hotfixes
- 1.0.9

**Files**: 9 Ruby files


---

## [MUI_001] Enhanced Pokemon UI

**Name**: [MUI] Enhanced Pokemon UI

**Version**: 1.0.6

**Author**: 

**Dependencies**:
- Modular UI Scenes
- 2.0.8

**Files**: 6 Ruby files


---

## [MUI_002] Pokedex Data Page

**Name**: 

**Version**: 2.0.3

**Author**: 

**Dependencies**:
- Modular UI Scenes
- 2.0.9

**Files**: 6 Ruby files


---

## [MUI_003] Improved Mementos

**Name**: [MUI] Improved Mementos

**Version**: 1.0.4

**Author**: 

**Dependencies**:
- Modular UI Scenes
- 2.0.8
- Deluxe Battle Kit
- 1.2.6

**Files**: 7 Ruby files


---

## [SV] Summary Screen

**Name**: [SV] Summary Screen

**Version**: 1.3

**Author**: 

**Dependencies**:
- Modular UI Scenes
- 2.0.8

**Files**: 8 Ruby files


---

## [XXX] Derxwna's Transition System

**Name**: 

**Version**: 1.0

**Author**: 

**Files**: 2 Ruby files


---

## [_En-1] Ivory Enhancers - Event Indicators

**Name**: Ivory Plugin Enhancer for TDW Event Indicators

**Version**: 2.1

**Author**: 

**Dependencies**:
- Event Indicators

**Files**: 1 Ruby files


---

## rainefallFogs

**Name**: rainefallFogs

**Version**: 2.1.0

**Author**: 

**Files**: 3 Ruby files

### Description

# rainefallFogs

New and improved, better terminology and easier to work with.

Map Overlays are per map and do not repeat. They are intended for use in place of fogs for lighting effects.
To use Map Overlays, add your lighting fog or whatever to Graphics/Fogs/Overlays (the folder will not exist, so create it)\
**IMPORTANT**: Your image should be HALF the size of your map, as it will be scaled up 2x by the script.

Fogs have been moved to Spriteset_Global, ensuring there will only ever be one fog in existence.
They work exactly the same as fogs otherwise.

Global Overlays are static images displayed above everything else, useful for vignette, static sunbeams etc
This is controlled with PBS, a property has been added to map_metadata.txt, OverlayName, which is the name of the image in Graphics/Fogs/Overlays to be displayed as a global overlay on that map.

---

## rainefallUtils

**Name**: rainefallUtils

**Version**: 1.2

**Author**: 

**Files**: 2 Ruby files


---

## v21.1 Hotfixes

**Name**: 

**Version**: 1.0.9

**Author**: 

**Files**: 3 Ruby files

