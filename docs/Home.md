# 📚 Pokémon Zorua - Dokumentation

Willkommen zur Dokumentation von Pokémon Zorua - The Divine Deception!

## 📖 Inhaltsverzeichnis

### Für Spieler

- [Installation](Installation.md)
- [Erste Schritte](Getting-Started.md)
- [Spielmechaniken](Gameplay-Mechanics.md)
- [FAQ](FAQ.md)

### Für Entwickler

- [Entwicklungs-Setup](Development-Setup.md)
- [Plugin-System](Plugin-System.md)
- [PBS Data System](PBS-Data-System.md)
- [Contributing Guide](../CONTRIBUTING.md)

### Plugin-Dokumentation

- [PBS Data System](plugins/PBS-Data-System.md)
- [Wind Animation System](plugins/Wind-Animation.md)
- [DBK Plugin Suite](plugins/DBK-Suite.md)
- [Event Templates](plugins/Event-Templates.md)

### Technische Dokumentation

- [Projekt-Struktur](Project-Structure.md)
- [Datei-Formate](File-Formats.md)
- [API Referenz](API-Reference.md)
- [Troubleshooting](Troubleshooting.md)

## 🚀 Quick Links

- [README](../README.md)
- [Changelog](../CHANGELOG.md)
- [Issues](https://github.com/99Problemsx/Zorua-the-divine-deception/issues)
- [Discussions](https://github.com/99Problemsx/Zorua-the-divine-deception/discussions)

## 🔧 Essentials Version

Dieses Projekt verwendet **Pokémon Essentials v21.1** mit **Hotfixes 1.0.9**.

## 💡 Schnellstart

### Spieler

```bash
1. Download neuestes Release
2. Entpacken
3. Game.exe starten
```

### Entwickler

```bash
git clone https://github.com/99Problemsx/Zorua-the-divine-deception.git
cd Zorua-the-divine-deception
# Mit MKXP-Z oder RPG Maker XP öffnen
```

## 🔌 Plugin-Übersicht

| Plugin               | Version | Beschreibung                  |
| -------------------- | ------- | ----------------------------- |
| PBS Data System      | 1.0.0   | Ruby-basierte PBS-Dateien     |
| Wind Animation       | 1.0.0   | Map-relative Windanimationen  |
| Luka's Utilities     | Latest  | Scripting Framework           |
| DBK Suite            | Latest  | Dynamax, Tera, Z-Power, Raids |
| Following Pokemon EX | Latest  | Pokemon folgen dem Spieler    |
| Arcky's Region Map   | Latest  | Erweiterte Karten             |

## 📝 Wichtige Konzepte

### PBS Data System

Das Projekt verwendet **Ruby-Klassen statt PBS-Textdateien**:

```ruby
# PBS/Data/Pokemon/gen_1.rb
Data::Species.register(:PIKACHU) do
  name "Pikachu"
  base_stats(hp: 35, attack: 55, defense: 40,
             special_attack: 50, special_defense: 50, speed: 90)
  types :ELECTRIC
  abilities :STATIC
end
```

**Vorteile:**

- ✅ Keine Kompilierung nötig
- ✅ Syntax-Highlighting
- ✅ Modulare Organisation
- ✅ Einfachere Versionskontrolle

### Auto-Data-Generation

Fehlende `.dat` Dateien werden automatisch erstellt:

```ruby
# [009] Compiler Override.rb
GameData.load_data("Data/trainer_types.dat")
# → Wird auto-generiert wenn nicht vorhanden
```

### Map-Relative Animationen

Wind-Animationen bewegen sich mit der Kamera:

```ruby
sprite.x = @ex + @x - $game_map.display_x / Game_Map::X_SUBPIXELS
sprite.y = @ey + @y - $game_map.display_y / Game_Map::Y_SUBPIXELS
```

## 🐛 Bekannte Probleme

Siehe [Issues](https://github.com/99Problemsx/Zorua-the-divine-deception/issues) für aktuelle Bugs und Feature Requests.

## 💬 Support

- **Bugs melden:** [Issues](https://github.com/99Problemsx/Zorua-the-divine-deception/issues/new?template=bug_report.md)
- **Features vorschlagen:** [Feature Requests](https://github.com/99Problemsx/Zorua-the-divine-deception/issues/new?template=feature_request.md)
- **Diskutieren:** [Discussions](https://github.com/99Problemsx/Zorua-the-divine-deception/discussions)

## 📜 Lizenz

Dieses Projekt ist ein nicht-kommerzielles Fan-Projekt basierend auf Pokémon Essentials v21.1.

Pokémon © Nintendo, Game Freak, Creatures Inc.

---

Made with ❤️ by 99Problemsx
