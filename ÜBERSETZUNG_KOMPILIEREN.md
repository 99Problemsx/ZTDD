# Übersetzungen kompilieren

## Übersicht

Die deutschen Übersetzungen befinden sich in zwei Ordnern:

- `Text_deutsch_game/` - Game-spezifische Übersetzungen (Items, Moves, Species, etc.)
- `Text_deutsch_core/` - Core Engine Übersetzungen (UI, System-Nachrichten, etc.)

Diese müssen zu `.dat` Dateien kompiliert werden, damit das Spiel sie laden kann.

## Automatische Kompilierung (Empfohlen)

### Schritt 1: Spiel im Debug-Modus starten

1. Spiel mit **F12** oder über `Game.exe` starten
2. Sicherstellen dass `$DEBUG = true` aktiv ist

### Schritt 2: Debug-Menü öffnen

- **Im Spiel**: `F9` oder über Pause-Menü → "Debug"
- **Im Kampf**: `F9` für Battle Debug Menu

### Schritt 3: Übersetzungen kompilieren

1. Debug-Menü → "Other options..." → "Files..."
2. Wähle **"Compile translated text"**
3. Es erscheint eine Liste mit gefundenen Translation-Ordnern:
   - `Text_deutsch_core`
   - `Text_deutsch_game`
4. Wähle **zuerst** `deutsch_core`, dann nochmal für `deutsch_game`

### Schritt 4: Übersetzungen aktivieren

Nach erfolgreicher Kompilierung existieren diese Dateien:

- `Data/messages_deutsch_core.dat`
- `Data/messages_deutsch_game.dat`

Um die deutschen Übersetzungen zu verwenden:

1. Bearbeite `mkxp.json` und ändere die Sprache (siehe unten)
2. **ODER** füge einen Sprach-Wechsler im Options-Menü hinzu

## Übersetzungen im Spiel verwenden

### Methode 1: mkxp.json (Global)

```json
{
  "language": "deutsch",
  "RTP1": "../../RPGXP/RPGXP",
  "RTP2": "../../RPGVX/RPGVX"
}
```

### Methode 2: Translation System (Zur Laufzeit)

```ruby
# Übersetzungsdatei laden
MessageTypes.load_message_files("deutsch")

# Text übersetzen mit _INTL
pbMessage(_INTL("Welcome to the world of Pokémon!"))
```

## Dateiformat der Übersetzungsdateien

Die Textdateien in `Text_deutsch_game/` und `Text_deutsch_core/` folgen diesem Format:

```
# Kommentare mit #
[SECTION_NAME]
Original Text
Übersetzter Text
Nächster Original Text
Nächster übersetzter Text
```

**Beispiel** (`ITEM_NAMES.txt`):

```
[ITEM_NAMES]
Black Augurite
Schwarzer Augurit
Peat Block
Torfblock
Poké Ball
Pokéball
```

## Übersetzungen bearbeiten

1. **NIE** die `.dat` Dateien direkt bearbeiten!
2. Bearbeite stattdessen die `.txt` Dateien in `Text_deutsch_game/` oder `Text_deutsch_core/`
3. Nach Änderungen: **Neu kompilieren** (siehe oben)

### Wichtige Dateien:

| Datei                      | Inhalt                             |
| -------------------------- | ---------------------------------- |
| `ITEM_NAMES.txt`           | Item-Namen                         |
| `MOVE_NAMES.txt`           | Attacken-Namen                     |
| `SPECIES_NAMES.txt`        | Pokémon-Namen                      |
| `ABILITY_NAMES.txt`        | Fähigkeiten-Namen                  |
| `TYPE_NAMES.txt`           | Typ-Namen                          |
| `ITEM_DESCRIPTIONS.txt`    | Item-Beschreibungen                |
| `MOVE_DESCRIPTIONS.txt`    | Attacken-Beschreibungen            |
| `ABILITY_DESCRIPTIONS.txt` | Fähigkeiten-Beschreibungen         |
| `EVENT_TEXTS.txt`          | Event-Texte (NPCs, Schilder, etc.) |

## Übersetzungen in PBS Data System verwenden

Das PBS Data System unterstützt automatische Übersetzungen:

```ruby
# In [010] Default Data.rb oder eigenen PBS-Dateien
GameData::Type.register({
  id:   :NORMAL,
  name: _INTL("Normal"),  # Automatisch übersetzt
  icon_position: 0
})
```

### Translation Helper verwenden:

```ruby
include PBSDataTranslation

# Einfache Übersetzung
name t("TYPE_FIRE")

# Mit Parametern
description format_t("Deals {1} damage", 50)

# Plural-Form
plural_t("Berry", 5)  # "Beeren" auf Deutsch

# Gender-spezifisch
gender_t("TRAINER", gender: :male)  # "Trainer"
gender_t("TRAINER", gender: :female)  # "Trainerin"
```

## Troubleshooting

### "No language folders found to compile"

- Überprüfe, dass Ordner `Text_deutsch_game/` und `Text_deutsch_core/` existieren
- Ordner müssen im **Root-Verzeichnis** des Spiels sein (nicht in `Data/` oder `Plugins/`)

### Übersetzungen werden nicht angezeigt

1. Überprüfe, ob `.dat` Dateien existieren:
   - `Data/messages_deutsch_core.dat`
   - `Data/messages_deutsch_game.dat`
2. Stelle sicher, dass `MessageTypes.load_message_files("deutsch")` aufgerufen wird
3. Überprüfe, ob `_INTL()` verwendet wird (nicht einfache Strings)

### Texte erscheinen auf Englisch

- Standard-Sprache ist Englisch
- Lade deutsche Übersetzungen mit `MessageTypes.load_message_files("deutsch")`
- Alternativ: Setze `language: "deutsch"` in `mkxp.json`

### Kompilierung schlägt fehl

- Überprüfe Textdatei-Format (jede Sektion muss gerade Anzahl Zeilen haben)
- Stelle sicher, dass Section-Header korrekt sind (z.B. `[ITEM_NAMES]`)
- Überprüfe auf ungültige Zeichen oder fehlende Zeilenumbrüche

## Neue Übersetzungen hinzufügen

### Schritt 1: Texte extrahieren

1. Debug-Menü → "Other options..." → "Files..."
2. Wähle **"Extract text from game files"**
3. Wähle Sprache (z.B. "deutsch") und Typ (Core/Game)
4. Neue `.txt` Dateien werden in `Text_deutsch_game/` oder `Text_deutsch_core/` erstellt

### Schritt 2: Texte übersetzen

Bearbeite die `.txt` Dateien und übersetze **jede zweite Zeile**:

```
Original English Text
Übersetzte deutsche Übersetzung
Another English Text
Noch eine deutsche Übersetzung
```

### Schritt 3: Kompilieren

Wie oben beschrieben über Debug-Menü → "Compile translated text"

## Best Practices

### ✅ DOs

- Verwende `_INTL()` für **alle** Texte die übersetzt werden sollen
- Kompiliere Übersetzungen nach jeder Änderung
- Behalte Formatierung (wie `\n`, `\1`, `{1}`, etc.) bei
- Teste Übersetzungen im Spiel nach Kompilierung

### ❌ DON'Ts

- NIE `.dat` Dateien direkt bearbeiten
- Keine Formatierungs-Tags entfernen (`\n`, `\1`, `{1}`)
- Nicht Section-Header ändern (`[ITEM_NAMES]` muss exakt so bleiben)
- Keine Zeilen hinzufügen oder entfernen (nur Übersetzungen ändern)

## Hinweise für PBS Data System

Das PBS Data System lädt automatisch Übersetzungen beim Spiel-Start. Du musst **nicht** manuell `load_message_files()` aufrufen, wenn:

1. Übersetzungen ordnungsgemäß kompiliert sind
2. Sprache in `mkxp.json` oder Options-Menü gesetzt ist
3. `_INTL()` in Ruby-Klassen verwendet wird

### Beispiel: Item-Definition

```ruby
GameData::Item.register({
  id:          :POKEBALL,
  name:        _INTL("Poké Ball"),  # ← Übersetzt aus ITEM_NAMES.txt
  description: _INTL("A device for catching wild Pokémon."),  # ← Übersetzt aus ITEM_DESCRIPTIONS.txt
  price:       200
})
```

**Nach Kompilierung:**

- Englisch: "Poké Ball" → "A device for catching wild Pokémon."
- Deutsch: "Pokéball" → "Ein Gerät zum Fangen wilder Pokémon."

## Weitere Informationen

- Siehe `Plugins/PBS Data System/[002] Translation Helper.rb` für Helper-Methoden
- Siehe `Data/Scripts/001_Technical/003_Intl_Messages.rb` für das Translation-System
- Dokumentation: `docs/plugins/PBS-Data-System.md`
