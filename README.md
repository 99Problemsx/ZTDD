<div align="center">

# 🎮 Pokémon Zorua - The Divine Deception

### *Ein ambitioniertes Fan-Game Projekt*

[![Pokémon Essentials](https://img.shields.io/badge/Pokémon_Essentials-v21.1-green?style=for-the-badge&logo=ruby)](https://github.com/Maruno17/pokemon-essentials)
[![Ruby](https://img.shields.io/badge/Ruby-3.0+-red?style=for-the-badge&logo=ruby)](https://www.ruby-lang.org/)
[![Status](https://img.shields.io/badge/Status-In_Development-yellow?style=for-the-badge)](https://github.com/99Problemsx/ZTDD/actions)
[![License](https://img.shields.io/badge/License-Fan_Project-blue?style=for-the-badge)](LICENSE)

[![CI/CD Pipeline](https://github.com/99Problemsx/ZTDD/actions/workflows/ci-pipeline.yml/badge.svg)](https://github.com/99Problemsx/ZTDD/actions/workflows/ci-pipeline.yml)
[![Security Scan](https://github.com/99Problemsx/ZTDD/actions/workflows/security-scan.yml/badge.svg)](https://github.com/99Problemsx/ZTDD/actions/workflows/security-scan.yml)
[![Code Quality](https://github.com/99Problemsx/ZTDD/actions/workflows/code-quality.yml/badge.svg)](https://github.com/99Problemsx/ZTDD/actions/workflows/code-quality.yml)

[📖 Dokumentation](https://99problemsx.github.io/ZTDD/) • [🎮 Releases](https://github.com/99Problemsx/ZTDD/releases) • [💬 Diskussionen](https://github.com/99Problemsx/ZTDD/discussions) • [🐛 Issues](https://github.com/99Problemsx/ZTDD/issues)

---

</div>

## 🌟 Highlights

<table>
<tr>
<td width="50%">

### 🎯 Game Features
- 🎮 **Gen 1-9 Pokémon** - Alle offiziellen Generationen
- ⚡ **Dynamax & Gigantamax** - Vollständig implementiert
- 🔮 **Terastallization** - Gen 9 Mechanik
- 💎 **Z-Moves** - Gen 7 System
- 🏟️ **Raid Battles** - Multiplayer-ready
- 🇩🇪 **Deutsche Lokalisierung** - Vollständig übersetzt

</td>
<td width="50%">

### 🔧 Technical Features
- 🔌 **Ruby-basiertes PBS** - Moderne Datenstruktur
- ⚡ **MKXP-Z Engine** - Optimierte Performance
- 🎨 **Custom Graphics** - Einzigartige Animationen
- 💾 **Auto-Data-Generation** - Automatische Kompilierung
- 🔄 **Modular Plugins** - 50+ Plugin-Systeme
- 🚀 **CI/CD Pipeline** - Automatisierte Tests & Builds

</td>
</tr>
</table>

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

## 📥 Quick Start

### 🎮 Für Spieler

```bash
# 1. Neuestes Release herunterladen
# Gehe zu: https://github.com/99Problemsx/ZTDD/releases/latest

# 2. Entpacke das Archiv
# 3. Starte Game.exe
```

### 👨‍💻 Für Entwickler

```bash
# Repository klonen
git clone https://github.com/99Problemsx/ZTDD.git
cd ZTDD

# Ruby installieren (3.0+)
# https://www.ruby-lang.org/de/downloads/

# MKXP-Z Runtime installieren (empfohlen)
# https://github.com/mkxp-z/mkxp-z/releases

# Spiel starten
./Game.exe
```

<details>
<summary>🔧 Erweiterte Setup-Optionen</summary>

### Entwicklungsumgebung einrichten

```bash
# Ruby Gems installieren
gem install rubocop rubocop-performance
gem install flog flay reek

# Git Hooks einrichten (optional)
git config core.hooksPath .github/hooks

# Pre-commit Hook für Syntax-Check
echo '#!/bin/bash
find Plugins -name "*.rb" -print0 | xargs -0 -n1 ruby -c
' > .github/hooks/pre-commit
chmod +x .github/hooks/pre-commit
```

### IDE Empfehlungen

- **Visual Studio Code** mit Ruby Extension
- **RubyMine** (JetBrains IDE)
- **Sublime Text** mit Ruby Plugin

</details>

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

## 📊 Projekt-Statistiken

<div align="center">

| Kategorie | Details |
|-----------|---------|
| 🔌 **Plugins** | 50+ installierte Plugins |
| 🎨 **Graphics** | 10,000+ PNG-Dateien |
| 🎵 **Audio** | 500+ Musikdateien |
| 📋 **PBS Files** | 100+ Daten-Definitionen |
| 💻 **Ruby Code** | 500,000+ Zeilen |
| 🌍 **Pokémon** | Gen 1-9 (1000+ Pokémon) |

</div>

## 🗺️ Roadmap

- [x] Basis-Gameplay (Gen 1-9 Pokémon)
- [x] Dynamax & Gigantamax System
- [x] Terastallization Implementation
- [x] Raid Battles Mechanik
- [x] Deutsche Übersetzung (Core)
- [ ] Story-Entwicklung
- [ ] Custom Region Maps
- [ ] Multiplayer-Features
- [ ] Custom Battle Frontier
- [ ] Release v1.0.0

## 🤝 Contributing

Wir freuen uns über jeden Beitrag! 

<details>
<summary>📝 Contribution Guidelines</summary>

### Wie kann ich beitragen?

1. **🐛 Bugs melden** - [Issue erstellen](https://github.com/99Problemsx/ZTDD/issues/new?template=bug_report.md)
2. **💡 Features vorschlagen** - [Feature Request](https://github.com/99Problemsx/ZTDD/issues/new?template=feature_request.md)
3. **📖 Dokumentation verbessern** - Pull Requests willkommen
4. **🔌 Plugins entwickeln** - Siehe [Plugin Development Guide](docs/PLUGIN_DEVELOPMENT.md)
5. **🎨 Assets beitragen** - Graphics, Audio, Sprites

### Development Workflow

```bash
# 1. Fork erstellen
# 2. Feature Branch erstellen
git checkout -b feature/amazing-feature

# 3. Änderungen committen
git commit -m "feat: Add amazing feature"

# 4. Push zum Fork
git push origin feature/amazing-feature

# 5. Pull Request öffnen
```

### Code Standards

- ✅ Ruby 3.0+ Syntax
- ✅ RuboCop-konform
- ✅ Deutsche oder englische Kommentare
- ✅ Essentials v21.1 Konventionen
- ✅ Tests für neue Features

### Commit-Konventionen

```
feat: Neue Funktion
fix: Bugfix
docs: Dokumentation
style: Formatierung
refactor: Code-Umstrukturierung
test: Tests hinzufügen
chore: Maintenance
```

</details>

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
