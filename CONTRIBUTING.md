# Contributing to Pokémon Zorua - The Divine Deception

Vielen Dank für dein Interesse an diesem Projekt! 🎉

## 📋 Inhaltsverzeichnis

- [Code of Conduct](#code-of-conduct)
- [Wie kann ich beitragen?](#wie-kann-ich-beitragen)
- [Entwicklungs-Setup](#entwicklungs-setup)
- [Pull Request Guidelines](#pull-request-guidelines)
- [Coding Standards](#coding-standards)
- [Plugin-Entwicklung](#plugin-entwicklung)

## 🤝 Code of Conduct

Dieses Projekt folgt einem Verhaltenskodex. Durch deine Teilnahme erklärst du dich damit einverstanden, respektvoll mit allen Community-Mitgliedern umzugehen.

## 🎯 Wie kann ich beitragen?

### Bug Reports

Bugs über [GitHub Issues](https://github.com/99Problemsx/Zorua-the-divine-deception/issues) melden:

1. **Suche zuerst** ob der Bug bereits gemeldet wurde
2. Verwende das Bug Report Template
3. Füge hinzu:
   - Schritte zur Reproduktion
   - Erwartetes vs. tatsächliches Verhalten
   - Screenshots/Logs wenn möglich
   - Essentials Version & Plugin-Liste

### Feature Requests

Neue Features vorschlagen:

1. Prüfe [Diskussionen](https://github.com/99Problemsx/Zorua-the-divine-deception/discussions)
2. Verwende das Feature Request Template
3. Beschreibe:
   - Use Case & Motivation
   - Erwartetes Verhalten
   - Mögliche Implementierung

### Code Contributions

1. **Fork** das Repository
2. **Clone** deinen Fork
3. Erstelle einen **Feature Branch**: `git checkout -b feature/amazing-feature`
4. **Committe** Änderungen: `git commit -m 'feat: Add amazing feature'`
5. **Push** zum Branch: `git push origin feature/amazing-feature`
6. Öffne einen **Pull Request**

## 🔧 Entwicklungs-Setup

### Voraussetzungen

```bash
# RPG Maker XP oder MKXP-Z
# Ruby 3.0+ (für Plugin-Entwicklung)
# Git
```

### Repository Setup

```bash
git clone https://github.com/99Problemsx/Zorua-the-divine-deception.git
cd Zorua-the-divine-deception

# Plugin Scripts löschen für frisches Laden
rm Data/PluginScripts.rxdata
```

### Testing

- Starte das Spiel mit `Game.exe` oder über MKXP-Z
- Drücke **F9** für Debug-Menü
- Prüfe `errorlog.txt` für Fehler
- Teste mit verschiedenen Save-Files

## 📝 Pull Request Guidelines

### Branch Naming

- `feature/` - Neue Features
- `fix/` - Bug Fixes
- `docs/` - Dokumentation
- `refactor/` - Code-Refactoring
- `test/` - Tests

### Commit Messages

Verwende [Conventional Commits](https://www.conventionalcommits.org/):

```
feat: Add new pokemon evolution method
fix: Resolve wind animation speed issue
docs: Update PBS Data System documentation
refactor: Simplify event template loader
```

**Types:**

- `feat:` - Neues Feature
- `fix:` - Bug Fix
- `docs:` - Dokumentation
- `style:` - Code-Formatierung
- `refactor:` - Code-Umstrukturierung
- `test:` - Tests
- `chore:` - Maintenance

### PR Checklist

- [ ] Code folgt den Coding Standards
- [ ] Keine Merge-Konflikte
- [ ] Getestet im Spiel
- [ ] Dokumentation aktualisiert
- [ ] Commit Messages folgen Convention
- [ ] Plugin-Kompatibilität geprüft

## 🎨 Coding Standards

### Ruby Style

```ruby
# Gute Beispiele:

# 1. Klassen in CamelCase
class WindAnimation
  def initialize
    @speed = 8
  end
end

# 2. Methoden in snake_case
def calculate_wind_speed
  @speed * Graphics.frame_rate.lerp(60.0)
end

# 3. Konstanten in SCREAMING_SNAKE_CASE
WIND_ANIMATION_SPEED = 8
MAX_SPRITE_COUNT = 3

# 4. Kommentare auf Deutsch oder Englisch
# Berechnet die Windgeschwindigkeit basierend auf Frame-Rate
def calculate_speed
  # ...
end
```

### Essentials Conventions

```ruby
# Event Handlers
EventHandlers.add(:on_game_start, :my_plugin,
  proc {
    # Initialization code
  }
)

# GameData Registration
Data::Species.register(:POKEMON_NAME) do
  name "Pokemon Name"
  base_stats(hp: 100, attack: 100, defense: 100,
             special_attack: 100, special_defense: 100, speed: 100)
end

# Plugin Organization
module MyPlugin
  VERSION = "1.0.0"

  class Manager
    # ...
  end
end
```

### PBS Data System

```ruby
# Verwende Data::Species statt GameData::Species
Data::Species.register(:PIKACHU) do
  name "Pikachu"
  # ... properties
end

# Alias-Methoden unterstützt
evolutions(:RAICHU => [:Item, :THUNDERSTONE])  # oder
evolution(:RAICHU => [:Item, :THUNDERSTONE])
```

## 🔌 Plugin-Entwicklung

### Plugin-Struktur

```
Plugins/
└── [XXX] My Plugin/
    ├── meta.txt          # Plugin-Metadaten
    ├── [000] Base.rb     # Basis-Klassen
    ├── [001] Manager.rb  # Haupt-Logik
    └── README.md         # Dokumentation
```

### meta.txt

```ini
Name = My Plugin
Version = 1.0.0
Essentials = 21.1
Link = https://github.com/user/plugin
Credits = Your Name
```

### Plugin Best Practices

1. **Namespace verwenden**: `module MyPlugin`
2. **EventHandlers**: Für Integration in Essentials
3. **Aliasing**: Statt Überschreiben von Methoden
4. **Kompatibilität**: Mit anderen Plugins testen
5. **Dokumentation**: README.md im Plugin-Ordner

### Beispiel-Plugin

```ruby
# [000] Base.rb
module MyPlugin
  VERSION = "1.0.0"

  class Manager
    def self.initialize
      puts "MyPlugin #{VERSION} loaded"
    end
  end
end

# [001] EventHandlers.rb
EventHandlers.add(:on_game_start, :my_plugin_init,
  proc {
    MyPlugin::Manager.initialize
  }
)
```

## 📚 Ressourcen

- [Pokémon Essentials Wiki](https://essentialsdocs.fandom.com/)
- [Ruby Style Guide](https://rubystyle.guide/)
- [Git Commit Convention](https://www.conventionalcommits.org/)
- [Markdown Guide](https://www.markdownguide.org/)

## 💬 Fragen?

- [Diskussionen](https://github.com/99Problemsx/Zorua-the-divine-deception/discussions)
- [Issues](https://github.com/99Problemsx/Zorua-the-divine-deception/issues)
- [Wiki](https://github.com/99Problemsx/Zorua-the-divine-deception/wiki)

---

Danke dass du zu Pokémon Zorua - The Divine Deception beiträgst! ❤️
