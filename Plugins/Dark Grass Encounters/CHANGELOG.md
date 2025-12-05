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
- [ ] Shiny rate modifier for dark grass

---

## Known Issues
- PokeRadar compatibility needs testing (mentioned in original v19 script)

## Bug Reports
If you find any bugs or issues, please report them with:
1. Your Essentials version
2. Steps to reproduce the issue
3. Any error messages
4. Your encounter configuration

---

## Version History

| Version | Date | Notes |
|---------|------|-------|
| 1.0.0 | Nov 18, 2025 | Initial release for v21.1 |
