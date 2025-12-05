# 🌐 Übersetzungssystem - Zorua: The Divine Deception

## Übersicht

Dieses Spiel verwendet das **Pokémon Essentials v21.1 Translation System** mit Unterstützung für mehrere Sprachen.

### Verfügbare Sprachen

- 🇩🇪 **Deutsch** (Standard) - Vollständig übersetzt
- 🇬🇧 **Englisch** - Fallback-Sprache

### Übersetzungs-Status

| Kategorie               | Deutsch | Englisch | Dateien                                         |
| ----------------------- | ------- | -------- | ----------------------------------------------- |
| **Items**               | ✅ 100% | ✅ 100%  | `ITEM_NAMES.txt`, `ITEM_DESCRIPTIONS.txt`       |
| **Moves**               | ✅ 100% | ✅ 100%  | `MOVE_NAMES.txt`, `MOVE_DESCRIPTIONS.txt`       |
| **Species**             | ✅ 100% | ✅ 100%  | `SPECIES_NAMES.txt`, `SPECIES_FORM_NAMES.txt`   |
| **Abilities**           | ✅ 100% | ✅ 100%  | `ABILITY_NAMES.txt`, `ABILITY_DESCRIPTIONS.txt` |
| **Types**               | ✅ 100% | ✅ 100%  | `TYPE_NAMES.txt`                                |
| **Trainer Types**       | ✅ 100% | ✅ 100%  | `TRAINER_TYPE_NAMES.txt`                        |
| **Nature Names**        | ✅ 100% | ✅ 100%  | `NATURE_NAMES.txt`                              |
| **Nature Descriptions** | ✅ 100% | ✅ 100%  | `NATURE_DESCRIPTIONS.txt`                       |
| **UI Text**             | ✅ 95%  | ✅ 100%  | Core-Dateien                                    |
| **Event Text**          | 🔄 80%  | ✅ 100%  | `EVENT_TEXTS.txt`                               |
| **Berry Descriptions**  | ✅ 100% | ✅ 100%  | `BerryDexDescriptions.txt`                      |

**Legende:** ✅ Fertig | 🔄 In Arbeit | ❌ Nicht übersetzt

---

## 📁 Dateistruktur

```
├── Text_deutsch_game/          # Game-spezifische Übersetzungen
│   ├── ITEM_NAMES.txt          # Item-Namen
│   ├── ITEM_DESCRIPTIONS.txt   # Item-Beschreibungen
│   ├── MOVE_NAMES.txt          # Attacken-Namen
│   ├── MOVE_DESCRIPTIONS.txt   # Attacken-Beschreibungen
│   ├── SPECIES_NAMES.txt       # Pokémon-Namen
│   ├── ABILITY_NAMES.txt       # Fähigkeiten-Namen
│   ├── TYPE_NAMES.txt          # Typ-Namen
│   ├── EVENT_TEXTS.txt         # Event-Texte (NPCs, Schilder)
│   └── ... (40+ weitere Dateien)
│
├── Text_deutsch_core/          # Core Engine Übersetzungen
│   ├── ITEM_NAMES.txt          # Core Item-Namen
│   ├── ABILITY_NAMES.txt       # Core Fähigkeiten
│   ├── UI_MESSAGES.txt         # UI-Nachrichten
│   └── ... (17+ weitere Dateien)
│
├── Data/
│   ├── messages_deutsch_game.dat    # ← Kompilierte Game-Übersetzungen
│   ├── messages_deutsch_core.dat    # ← Kompilierte Core-Übersetzungen
│   ├── messages_game.dat            # Standard (Englisch)
│   └── messages_core.dat            # Standard (Englisch)
│
└── ÜBERSETZUNG_KOMPILIEREN.md  # Detaillierte Anleitung
```

---

## 🚀 Schnellstart: Übersetzungen kompilieren

### Methode 1: Debug-Menü (Empfohlen)

1. **Spiel starten** (im Debug-Modus mit F12)
2. **F9** drücken für Debug-Menü
3. **Other options... → Files... → Compile translated text**
4. Wähle nacheinander:
   - `deutsch_core`
   - `deutsch_game`

### Methode 2: PowerShell-Skript (Windows)

```powershell
.\compile_translations.ps1
```

Dieses Skript überprüft die Übersetzungsdateien und zeigt Anweisungen zur Kompilierung.

### Methode 3: Ruby-Skript

```bash
ruby compile_translations.rb
```

_Hinweis: Erfordert Essentials-Umgebung_

---

## ⚙️ Übersetzungen aktivieren

### Option 1: mkxp.json (Global)

Bearbeite `mkxp.json` im Root-Verzeichnis:

```json
{
  "language": "deutsch",
  "RTP1": "../../RPGXP/RPGXP",
  "RTP2": "../../RPGVX/RPGVX"
}
```

### Option 2: Zur Laufzeit (Ruby Code)

```ruby
# Übersetzungen laden
MessageTypes.load_message_files("deutsch")

# Text übersetzen
pbMessage(_INTL("Welcome to the world of Pokémon!"))
# → "Willkommen in der Welt der Pokémon!"
```

---

## 📝 Übersetzungen bearbeiten

### Wichtige Regeln

✅ **DOs:**

- Bearbeite **nur** `.txt` Dateien in `Text_deutsch_game/` oder `Text_deutsch_core/`
- Übersetze **jede zweite Zeile** (Original → Übersetzung)
- Behalte Formatierungs-Tags bei: `\n`, `\1`, `{1}`, `{2}`, etc.
- Kompiliere nach jeder Änderung neu

❌ **DON'Ts:**

- NIE `.dat` Dateien direkt bearbeiten!
- Keine Section-Header ändern (z.B. `[ITEM_NAMES]`)
- Keine Zeilen hinzufügen oder entfernen
- Keine Formatierungs-Tags entfernen

### Beispiel: Item übersetzen

**Datei:** `Text_deutsch_game/ITEM_NAMES.txt`

```
[ITEM_NAMES]
Poké Ball          ← Original (Zeile 1)
Pokéball           ← Übersetzung (Zeile 2)
Great Ball         ← Original (Zeile 3)
Superball          ← Übersetzung (Zeile 4)
```

**Nach Änderung:**

1. Speichere die Datei
2. Kompiliere neu (Debug-Menü → Compile translated text)
3. Starte das Spiel neu und teste

---

## 🔧 Übersetzungen in Code verwenden

### Standard: \_INTL() Funktion

```ruby
# Einfacher Text
pbMessage(_INTL("Welcome to the world of Pokémon!"))

# Mit Parametern
pbMessage(_INTL("You received {1} {2}!", 5, "Poké Balls"))
# → "Du hast 5 Pokébälle erhalten!"

# Formatierung
pbMessage(_INTL("Welcome, {1}!", $player.name))
```

### PBS Data System: Translation Helper

Das PBS Data System bietet zusätzliche Helper-Methoden:

```ruby
include PBSDataTranslation

# Typ-Namen
type_name(:FIRE)        # → "Feuer"

# Plural-Form
plural_t("Berry", 5)    # → "Beeren"

# Gender-spezifisch
gender_t("TRAINER", gender: :male)    # → "Trainer"
gender_t("TRAINER", gender: :female)  # → "Trainerin"

# Formatierung mit Variablen
format_t("You received {1} {2}!", 5, "Berries")
# → "Du hast 5 Beeren erhalten!"
```

### In Ruby-Klassen (PBS Data System)

```ruby
GameData::Item.register({
  id:          :POKEBALL,
  name:        _INTL("Poké Ball"),  # ← Automatisch übersetzt
  description: _INTL("A device for catching wild Pokémon."),
  price:       200
})

# Resultat:
# Englisch: "Poké Ball" / "A device for catching wild Pokémon."
# Deutsch:  "Pokéball"  / "Ein Gerät zum Fangen wilder Pokémon."
```

---

## 🐛 Troubleshooting

### Problem: "No language folders found to compile"

**Lösung:**

- Überprüfe, dass `Text_deutsch_game/` und `Text_deutsch_core/` existieren
- Ordner müssen im **Root-Verzeichnis** sein (nicht in `Data/` oder `Plugins/`)

### Problem: Übersetzungen werden nicht angezeigt

**Lösung:**

1. Überprüfe, ob `.dat` Dateien existieren:
   ```powershell
   Get-ChildItem "Data\messages_deutsch_*.dat"
   ```
2. Stelle sicher, dass Sprache geladen ist:
   ```ruby
   MessageTypes.load_message_files("deutsch")
   ```
3. Überprüfe, ob `_INTL()` verwendet wird

### Problem: Texte erscheinen auf Englisch

**Lösung:**

- Standard-Sprache ist Englisch
- Setze `language: "deutsch"` in `mkxp.json`
- Oder lade manuell: `MessageTypes.load_message_files("deutsch")`

### Problem: Kompilierung schlägt fehl

**Mögliche Ursachen:**

- **Ungerade Zeilenanzahl:** Jede Sektion muss gerade Anzahl Zeilen haben
- **Fehlende Section-Header:** Überprüfe `[SECTION_NAME]` Format
- **Ungültige Zeichen:** Stelle sicher, dass Datei UTF-8 kodiert ist

**Lösung:**

```powershell
# Überprüfe Dateiformat
Get-Content "Text_deutsch_game\ITEM_NAMES.txt" -Encoding UTF8 | Select-Object -First 10

# Überprüfe Zeilenanzahl (muss gerade sein)
(Get-Content "Text_deutsch_game\ITEM_NAMES.txt").Count
```

---

## 🆕 Neue Übersetzungen hinzufügen

### Schritt 1: Texte extrahieren

1. Debug-Menü → **"Extract text from game files"**
2. Wähle:
   - **Sprache:** "deutsch"
   - **Type:** "Game" oder "Core"
   - **Separate map files:** Nein (empfohlen)
3. Neue `.txt` Dateien werden erstellt

### Schritt 2: Texte übersetzen

Bearbeite die `.txt` Dateien und übersetze **jede zweite Zeile**:

```
Original English Text
Übersetzte deutsche Version
Another English Text
Noch eine deutsche Übersetzung
```

### Schritt 3: Kompilieren

Debug-Menü → **"Compile translated text"** → Wähle `deutsch_game` / `deutsch_core`

### Schritt 4: Testen

Starte das Spiel und teste die neuen Übersetzungen.

---

## 📚 Wichtige Dateien

### Game-spezifische Übersetzungen

| Datei                      | Beschreibung                                |
| -------------------------- | ------------------------------------------- |
| `ITEM_NAMES.txt`           | Item-Namen (Pokéball, Trank, etc.)          |
| `ITEM_DESCRIPTIONS.txt`    | Item-Beschreibungen                         |
| `MOVE_NAMES.txt`           | Attacken-Namen (Tackle, Flamethrower, etc.) |
| `MOVE_DESCRIPTIONS.txt`    | Attacken-Beschreibungen                     |
| `SPECIES_NAMES.txt`        | Pokémon-Namen (Pikachu, Charizard, etc.)    |
| `SPECIES_FORM_NAMES.txt`   | Form-Namen (Alola-Form, Mega-Form, etc.)    |
| `ABILITY_NAMES.txt`        | Fähigkeiten-Namen (Overgrow, Blaze, etc.)   |
| `ABILITY_DESCRIPTIONS.txt` | Fähigkeiten-Beschreibungen                  |
| `TYPE_NAMES.txt`           | Typ-Namen (Fire, Water, Grass, etc.)        |
| `TRAINER_TYPE_NAMES.txt`   | Trainer-Klassen (Leader, Youngster, etc.)   |
| `NATURE_NAMES.txt`         | Wesen-Namen (Hardy, Lonely, etc.)           |
| `NATURE_DESCRIPTIONS.txt`  | Wesen-Beschreibungen                        |
| `RIBBON_NAMES.txt`         | Band-Namen                                  |
| `RIBBON_DESCRIPTIONS.txt`  | Band-Beschreibungen                         |
| `EVENT_TEXTS.txt`          | Event-Texte (NPCs, Schilder, etc.)          |
| `BerryDexDescriptions.txt` | Beeren-Beschreibungen                       |

### Core Engine Übersetzungen

| Datei                      | Beschreibung                    |
| -------------------------- | ------------------------------- |
| `ITEM_NAMES.txt`           | Core Item-Namen                 |
| `ITEM_DESCRIPTIONS.txt`    | Core Item-Beschreibungen        |
| `ABILITY_NAMES.txt`        | Core Fähigkeiten                |
| `ABILITY_DESCRIPTIONS.txt` | Core Fähigkeiten-Beschreibungen |
| `ITEM_NAME_PLURALS.txt`    | Plural-Formen von Items         |

---

## 🛠️ Erweiterte Verwendung

### Eigene Translation Helper erstellen

```ruby
# In eigener Plugin-Datei
module MyTranslations
  def translate_custom(key)
    # Lade aus eigener Translation-Datei
    MessageTypes.getFromHash(MessageTypes::CUSTOM_SECTION, key)
  end
end

# Verwendung
include MyTranslations
translate_custom("MY_CUSTOM_KEY")
```

### Dynamische Übersetzungen

```ruby
# Übersetzung zur Laufzeit wechseln
def switch_language(lang)
  MessageTypes.load_message_files(lang)
  pbMessage(_INTL("Language changed to {1}", lang))
end

# Verwendung
switch_language("deutsch")  # → "Sprache geändert zu deutsch"
switch_language("english")  # → "Language changed to english"
```

### Eigene Sections hinzufügen

```ruby
# In [002] Translation Helper.rb oder eigener Datei
module MessageTypes
  CUSTOM_TEXTS = 999
end

# Texte setzen
MessageTypes.setMessagesAsHash(MessageTypes::CUSTOM_TEXTS, [
  "Custom Text 1",
  "Custom Text 2"
])

# Texte abrufen
pbMessage(MessageTypes.get(MessageTypes::CUSTOM_TEXTS, 0))
# → "Custom Text 1"
```

---

## 📖 Weitere Ressourcen

- **Detaillierte Anleitung:** [ÜBERSETZUNG_KOMPILIEREN.md](ÜBERSETZUNG_KOMPILIEREN.md)
- **PBS Data System Doku:** [docs/plugins/PBS-Data-System.md](docs/plugins/PBS-Data-System.md)
- **Translation Helper Code:** `Plugins/PBS Data System/[002] Translation Helper.rb`
- **Essentials Translation System:** `Data/Scripts/001_Technical/003_Intl_Messages.rb`

---

## 🤝 Mitwirken

### Neue Übersetzungen beitragen

1. Forke das Repository
2. Erstelle einen Branch: `git checkout -b feature/neue-uebersetzungen`
3. Bearbeite die `.txt` Dateien in `Text_deutsch_game/` oder `Text_deutsch_core/`
4. Kompiliere und teste die Übersetzungen
5. Committe deine Änderungen: `git commit -m "feat: Neue Übersetzungen für X"`
6. Push zum Branch: `git push origin feature/neue-uebersetzungen`
7. Erstelle einen Pull Request

### Übersetzungs-Richtlinien

- Verwende einheitliche Terminologie (z.B. "Pokéball" nicht "Poké Ball")
- Behalte Pokémon-Namen im Original (z.B. "Pikachu" nicht "Pikachu")
- Übersetze Attacken-Namen konsistent (siehe offizielle deutsche Übersetzungen)
- Teste alle Übersetzungen im Spiel

---

## 📄 Lizenz

Siehe [LICENSE](LICENSE) für Details.

---

**Viel Erfolg mit den Übersetzungen! 🎉**

Bei Fragen oder Problemen erstelle bitte ein Issue auf GitHub.
