# 🎮 Pokémon Zorua - The Divine Deception

![Pokémon Essentials](https://img.shields.io/badge/Pokémon_Essentials-v21.1-green?style=for-the-badge) ![Ruby](https://img.shields.io/badge/Ruby-3.0+-red?style=for-the-badge) ![Status](https://img.shields.io/badge/Status-In_Development-yellow?style=for-the-badge)

🌐 Aktueller Branch: Main - Spielentwicklung

[📖 Wiki](https://github.com/99Problemsx/Zorua-the-divine-deception/wiki) • [💬 Diskussionen](https://github.com/99Problemsx/Zorua-the-divine-deception/discussions) • [🐛 Issues](https://github.com/99Problemsx/Zorua-the-divine-deception/issues)

## 📂 Über Zorua - The Divine Deception

Pokémon Zorua - The Divine Deception ist ein ambitioniertes Fan-Game basierend auf Pokémon Essentials v21.1 - ein umfangreiches Framework für RPG Maker XP, das es ermöglicht, eigene Pokémon-Spiele zu erstellen.

### ✨ Features

• 🎮 **Alle offiziellen Pokémon** - Gen 1-9 Pokemon aus allen offiziellen Generationen
• 🔌 **Advanced Plugin-System** - PBS Data System, Wind Animation, und viele mehr
• 🇩🇪 **Deutsche Lokalisierung** - Vollständig auf Deutsch übersetzt
• ⚡ **MKXP-Z Engine** - Moderne Engine mit besserer Performance
• 🎨 **Custom Graphics** - Einzigartige Animationen und Effekte
• 🔄 **Ruby-basiertes PBS System** - Keine Textdateien, alles in Ruby-Klassen
• 💾 **Auto-Data-Generation** - Fehlende .dat Dateien werden automatisch erstellt

## 🛠️ Plugin-Übersicht

### Core Plugins

- **PBS Data System** - Ersetzt PBS-Textdateien durch Ruby-Klassen mit DSL
- **Luka's Scripting Utilities** - Framework-Erweiterungen und Hilfsfunktionen
- **Wind Animation System** - Map-relative Windanimationen mit Frame-Rate-Kompensation
- **Event Templating System** - Template-basierte Event-Verwaltung

### Game Mechanics

- **DBK Plugins Suite** - Dynamax, Terastallization, Z-Power, Raid Battles
- **Animated Pokemon System** - Animierte Pokemon-Sprites
- **Challenge Modes** - Verschiedene Schwierigkeitsmodi

### UI & Quality of Life

- **Arcky's Region Map** - Erweiterte Regionskarten-Funktionalität
- **Following Pokemon EX** - Pokemon folgen dem Spieler
- **Advanced Pokemon Storage** - Verbessertes PC-System

## 📥 Installation

### Für Spieler

1. Gehe zu [Releases](https://github.com/99Problemsx/Zorua-the-divine-deception/releases/latest)
2. Lade das neueste Release herunter
3. Entpacke das Archiv
4. Starte `Game.exe`

### Für Entwickler

```bash
# Repository klonen
git clone https://github.com/99Problemsx/Zorua-the-divine-deception.git
cd Zorua-the-divine-deception

# Direkt mit RPG Maker XP oder MKXP-Z öffnen
```

## 🔧 Entwicklung

### Voraussetzungen

- MKXP-Z Runtime (empfohlen) oder RPG Maker XP
- Ruby 3.0+ (für Plugin-Entwicklung)
- Pokémon Essentials v21.1 (bereits enthalten)
- Git für Versionskontrolle

### Projekt-Struktur

```
Zorua-the-divine-deception/
├── PBS/                    # Pokémon Battle System
│   ├── Data/              # Ruby-basierte Daten (Gen 1-9)
│   │   ├── Pokemon/       # Pokemon-Definitionen
│   │   ├── Moves/         # Attacken-Definitionen
│   │   ├── Items/         # Item-Definitionen
│   │   ├── Abilities/     # Fähigkeiten
│   │   └── Types/         # Typ-Definitionen
│   └── *.txt              # PBS Textdateien (Backup)
├── Plugins/               # Ruby-Plugins
│   ├── PBS Data System/   # PBS → Ruby Konverter
│   ├── Wind Animation/    # Animations-System
│   └── [DBK_*]/          # DBK Plugin-Suite
├── Graphics/              # Grafiken & Sprites
│   ├── Battlers/         # Kampf-Sprites
│   ├── Characters/       # Overworld-Sprites
│   └── Animations/       # Battle-Animationen
├── Audio/                # Musik & Sounds
│   ├── BGM/              # Hintergrundmusik
│   └── SE/               # Sound-Effekte
├── Data/                 # Kompilierte Spieldaten
│   ├── *.rxdata          # RMXP Datenfiles
│   └── *.dat             # Essentials Daten
└── Save Files/           # Spielstände

```

### PBS Data System

Das Projekt verwendet ein **revolutionäres Ruby-basiertes PBS System**:

```ruby
# Beispiel: PBS/Data/Pokemon/gen_1.rb
Data::Species.register(:PIKACHU) do
  name "Pikachu"
  base_stats(
    hp: 35, attack: 55, defense: 40,
    special_attack: 50, special_defense: 50, speed: 90
  )
  types :ELECTRIC
  abilities :STATIC
  evolutions(:RAICHU => [:Item, :THUNDERSTONE])
  moves(
    1 => :THUNDERSHOCK,
    5 => :TAILWHIP,
    10 => :QUICKATTACK
  )
end
```

**Vorteile:**

- ✅ Keine Textdatei-Kompilierung nötig
- ✅ Ruby-Syntax-Highlighting & IDE-Support
- ✅ Modulare Organisation (Gen 1-9 in separaten Dateien)
- ✅ Auto-Loading beim Spielstart
- ✅ Einfachere Versionskontrolle

### Debugging

- Drücke **F12** für Soft Reset
- **F9** öffnet das Debug-Menü (im Test-Modus)
- Prüfe `errorlog.txt` bei Fehlern
- Logs in `luts_log.txt` für Scripting Utilities

### Wichtige Dateien

- `Game.ini` - Spielkonfiguration
- `mkxp.json` - MKXP-Z Engine-Einstellungen
- `Plugins/*/meta.txt` - Plugin-Metadaten
- `PBS/Data/*/*.rb` - Alle Spieldaten in Ruby

## 🔄 Workflow

### Änderungen vornehmen

```bash
# Branch erstellen
git checkout -b feature/mein-feature

# Änderungen machen
# ... Code bearbeiten ...

# Committen
git add .
git commit -m "feat: Neue Funktion hinzugefügt"

# Push und Pull Request
git push origin feature/mein-feature
```

### Scripts neu kompilieren

```powershell
# Plugin-Scripts löschen für Neuladung
Remove-Item "Data\PluginScripts.rxdata"

# Optional: Alle Scripts neu kompilieren
Remove-Item "Data\Scripts.rxdata"
```

## 📚 Plugin-Dokumentation

### PBS Data System

- Ersetzt PBS-Textdateien durch Ruby-DSL
- Auto-generiert fehlende .dat Files
- Lädt alle Pokemon Gen 1-9 automatisch
- Siehe `Plugins/PBS Data System/README.md`

### Wind Animation System

- Map-relative Positionierung
- Frame-Rate unabhängige Animation
- 3-stufiges Animations-System
- SPEED-Konstante für Geschwindigkeitskontrolle

### DBK Plugin Suite

- Dynamax & Gigantamax
- Terastallization
- Z-Moves & Z-Power
- Raid Battles
- Max Lair Adventures

## 🤝 Mitarbeit

Beiträge sind willkommen! Bitte beachte:

1. **Fork** das Repository
2. Erstelle einen **Feature-Branch**
3. **Committe** deine Änderungen
4. **Push** zum Branch
5. Öffne einen **Pull Request**

### Code-Standards

- Ruby 3.0+ Syntax
- Kommentare auf Deutsch oder Englisch
- Essentials v21.1 Konventionen folgen
- Plugin-Kompatibilität testen

## 📜 Lizenz

Pokémon und alle zugehörigen Namen sind Handelsmarken von Nintendo, Game Freak und Creatures Inc.

Dieses Projekt ist ein **nicht-kommerzielles Fan-Projekt** und steht in keiner Verbindung zu den o.g. Unternehmen.

Der verwendete Code basiert auf Pokémon Essentials v21.1 und steht unter deren Lizenz.

### Credits

- **Pokémon Essentials Team** - Framework
- **Maruno** - Essentials Creator
- **Luka S.J.** - Scripting Utilities & PBS System Inspiration
- **DBK** - Dynamax/Raid/Tera Plugins
- **Arcky** - Region Map Plugin
- **99Problemsx** - Projekt-Entwicklung

Made with ❤️ using Pokémon Essentials v21.1

---

[🐛 Bug melden](https://github.com/99Problemsx/Zorua-the-divine-deception/issues/new?template=bug_report.md) • [💡 Feature vorschlagen](https://github.com/99Problemsx/Zorua-the-divine-deception/issues/new?template=feature_request.md) • [💬 Diskussion starten](https://github.com/99Problemsx/Zorua-the-divine-deception/discussions/new)
