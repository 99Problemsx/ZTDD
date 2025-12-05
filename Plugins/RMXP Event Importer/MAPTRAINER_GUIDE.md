# MapTrainer + Event Importer Fusion

## ✅ What Was Done

Merged the MapTrainer System into the RMXP Event Importer plugin, creating a unified solution for defining trainer battles directly in event text files.

## 📁 Files Created/Modified

### New Files:

1. **`Plugins/RMXP Event Importer/003_MapTrainer_Integration.rb`**

   - Core MapTrainer system integrated into Event Importer
   - Handles trainer registration and battle management
   - Adds MAPTRAINER command parser

2. **`EventImporter/map002_trainers_example.txt`**
   - Complete examples of MAPTRAINER usage
   - Shows simple to advanced trainer setups

### Modified Files:

1. **`Plugins/RMXP Event Importer/README.md`**
   - Added trainer battle documentation section
   - Included MAPTRAINER command examples

## 🎮 How to Use

### Basic Syntax

```
MAPTRAINER: TYPE, Name, "Lose text"
  POKEMON: SPECIES, level
  POKEMON: SPECIES, level
END_MAPTRAINER
```

### Advanced Features

```
MAPTRAINER: YOUNGSTER, Ben, "I lost!"
  TRAINER_INTRO: Custom intro text before battle
  TRAINER_ITEMS: POTION, POKEBALL, SUPER_POTION

  # Simple Pokemon
  POKEMON: RATTATA, 5

  # Pokemon with moves
  POKEMON: PIDGEY, 6, moves: GUST, SAND_ATTACK

  # Pokemon with everything
  POKEMON: PIKACHU, 10, ability: STATIC, item: LIGHT_BALL, gender: female, moves: THUNDERBOLT, QUICK_ATTACK
END_MAPTRAINER
```

### Complete Event Example

```
EVENT: Camper Liam, X: 16, Y: 8
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

## 🔧 Features

### Automatic Handling:

- ✅ **Self Switch Management** - Trainers can only be battled once (self switch A is set on win)
- ✅ **NPCTrainer Creation** - Automatically creates proper NPCTrainer objects
- ✅ **Battle Integration** - Uses `TrainerBattle.start` internally
- ✅ **Re-battle Prevention** - Checks self switch before starting battle

### Pokemon Customization:

- Species and level (required)
- Custom moves (up to 4)
- Abilities
- Held items
- Gender (male/female/genderless)

### Trainer Customization:

- Trainer type and name
- Lose text (what they say when defeated)
- Intro text (shown before battle starts)
- Trainer items (potions, revives, etc.)

## 🎯 How It Works

1. **Event Import**: When you import events from text files, the MAPTRAINER command is parsed
2. **Pokemon Creation**: Each POKEMON line creates a real Pokemon object with stats, moves, etc.
3. **Registration**: Trainer is registered with `GameData::MapTrainer` using map ID and event ID
4. **Event Script**: Automatically adds `GameData::MapTrainer.notice(self)` to the event
5. **Battle Time**: When event runs, MapTrainer system finds the trainer and starts the battle
6. **Victory Handling**: On win, self switch A is set to prevent re-battling

## 📝 Migration from Old System

### Old Way (PBS/Maps/Trainers/\*.rb):

```ruby
module Data
  module Trainers
    class Map2 < GameData::MapTrainer
      register(15, :CAMPER, "Liam") do |t|
        t.party << Pokemon.new(:RATTATA, 5)
        t.party << Pokemon.new(:PIDGEY, 6)
      end
    end
  end
end
```

### New Way (EventImporter/\*.txt):

```
EVENT: Camper Liam, X: 16, Y: 8
GRAPHIC: trainer_CAMPER
TRIGGER: Action
CONDITIONAL: SELF_SWITCH A == OFF
  MAPTRAINER: CAMPER, Liam, "You won!"
    POKEMON: RATTATA, 5
    POKEMON: PIDGEY, 6
  END_MAPTRAINER
```

**Benefits of new way:**

- Event and trainer defined in one place
- No need for separate trainer files
- Visual positioning (X, Y coordinates)
- Graphics and triggers included
- Self switch handling automatic

## 🚀 Testing

1. Create a test file: `EventImporter/map002_test.txt`
2. Add a trainer event using MAPTRAINER syntax
3. Press F9 in game → Debug → Import Events for Map 2
4. Talk to the trainer event
5. Battle should start automatically
6. After winning, talking again should show defeated text

## 🔍 Debug Output

The system provides extensive debug logging:

- `✓ Registered MapTrainer: Map X, Event Y - TYPE Name`
- `MapTrainer.notice: Found trainer on Map X, Event Y`
- `Starting battle: TYPE Name`
- `Battle ended with result: true/false`
- `Trainer defeated, self switch A set to true`

## 📚 Next Steps

You can now:

1. Delete old `PBS/Maps/Trainers/*.rb` files if you want
2. Delete `Plugins/PBS Data System/[007] MapTrainer System.rb` (functionality now in Event Importer)
3. Create all your trainers in `EventImporter/*.txt` files instead
4. Use F9 Debug menu to import/update events anytime

## 💡 Tips

- Use `CONDITIONAL: SELF_SWITCH A == OFF` to prevent showing battle text when already defeated
- Use `CONDITIONAL: ELSE` to show post-defeat text
- TRAINER_INTRO is optional but makes battles feel more polished
- TRAINER_ITEMS lets trainers use items during battle (like gym leaders)
- Gender parameter: `male`, `female`, `m`, `f`, `0`, `1` all work

---

**Status**: ✅ Complete and ready to use!
