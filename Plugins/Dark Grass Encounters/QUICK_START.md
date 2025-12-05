# Quick Start Guide - Dark Grass Encounters

## 5-Minute Setup

### 1. Install the Plugin ✓
   The plugin is already in your `Plugins` folder. Just compile your game!

### 2. Add Dark Grass Tiles
   - Open your tileset graphic
   - Create a darker/different variant of your grass tile
   - Save it

### 3. Assign Terrain Tag 18
   - Press **F8** to enter Debug mode
   - Open map in editor
   - Select your dark grass tiles
   - Set **Terrain Tag = 18** (DarkGrass)

### 4. Define Encounters
   Open `PBS/encounters.txt` and add:

   ```
   [YOUR_MAP_ID]
   DarkGrass,12,10,10,10,10,8,8,8,8,6,6,4,4
     POKEMON1,15,20
     POKEMON2,15,20
     POKEMON1,17,22
     POKEMON2,17,22
     POKEMON1,19,24
     POKEMON2,19,24
     POKEMON3,20,25
     POKEMON4,20,25
     POKEMON3,22,27
     POKEMON4,22,27
     POKEMON3,24,29
     POKEMON4,24,29
   ```

### 5. Test It!
   - Compile (delete `Data/PluginScripts.rxdata` if needed)
   - Start game
   - Walk on your dark grass tiles
   - Encounters should trigger with your defined Pokémon!

## Optional: Add Custom Battle Music

Edit `Plugins/Dark Grass Encounters/003_BattleAudio.rb`:

Find this line (around line 17):
```ruby
# ret = pbStringToAudioFile("Battle dark grass") if !ret
```

Uncomment it and change the filename:
```ruby
ret = pbStringToAudioFile("YourMusicFileName") if !ret
```

Place your music file in `Audio/BGM/YourMusicFileName.ogg` (or .mp3)

## That's it!

Your dark grass encounters are now working! Check the README.md for advanced features.

## Common Issues

**Q: Encounters not working?**
- Make sure you assigned Terrain Tag 18 correctly
- Verify encounters are defined in PBS/encounters.txt
- Compile your game data

**Q: Wrong Pokémon appearing?**
- Check your map ID in encounters.txt matches your actual map
- Make sure you're using `DarkGrass` not `Land` for the encounter type

**Q: No grass rustle animation?**
- This is normal, the animation should appear
- Make sure your tileset has the grass tile set up properly

Need more help? Check README.md for full documentation!
