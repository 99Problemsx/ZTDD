# ❓ FAQ - Pokémon Zorua: The Divine Deception# ❓ FAQ - Pokémon Zorua: The Divine Deception

Häufig gestellte Fragen und Antworten!Häufig gestellte Fragen und Antworten!

---

## 🎮 Allgemein## 🎮 Gameplay

### Was ist "Pokémon Zorua - The Divine Deception"?### What version of Pokemon Essentials is this?

Ein umfangreiches Pokémon Fan-Game basierend auf **Pokémon Essentials v21.1**. Das Spiel bietet eine einzigartige Story über Täuschungen, göttliche Kräfte und die Natur der Realität. Mit allen Pokémon Gen 1-9, dem neuen Sound-Type und vielen einzigartigen Features!**v21.1** with official Hotfixes **1.0.9**.

### Ist das Spiel kostenlos?### What features are included?

**Ja!** Das Spiel ist komplett kostenlos und non-profit. Es ist ein Fan-Projekt für Bildungszwecke.- Deluxe Battle Kit (Raid Battles, Dynamax, Z-Moves, Terastallization)

- Sound Type (custom type)

### Für welche Plattformen ist es verfügbar?- German localization

Aktuell nur für **Windows** (7/8/10/11). Mac und Linux Support ist für die Zukunft geplant.- 50+ custom plugins

### Wie lange ist das Spiel?See **[Gameplay Features](Gameplay-Features)** for complete list.

- **Hauptstory**: ~40 Stunden

- **Post-Game**: ~20+ Stunden### Can I play this in English?

- **100% Completion**: ~80-100 StundenCurrently only German is fully supported. English translation is planned.

- **Shiny Hunt / Competitive**: Unbegrenzt!

### Where are save files stored?

### Gibt es Multiplayer?In the game folder: `Game_*.rxdata`

Aktuell nur **lokal** (Raid Battles). Online Battles sind für zukünftige Updates geplant.

**Tip**: Backup these files regularly!

---

### How do I transfer saves between versions?

## 💾 Installation & Technical1. Copy `Game_*.rxdata` from old version

2. Paste into new version folder

### Wo kann ich das Spiel herunterladen?3. Start game normally

[GitHub Releases](https://github.com/99Problemsx/Zorua-the-divine-deception/releases) - Lade immer die neueste Version herunter!

---

### Wie installiere ich das Spiel?

1. Lade die ZIP-Datei herunter## 🔧 Technical

2. Entpacke sie in einen Ordner

3. Starte `Game.exe`### What are the system requirements?

**Minimum**:

Mehr Details im **[Installation Guide](Getting-Started#-installation)**.- Windows 7+

- 2 GB RAM

### Das Spiel startet nicht! Was tun?- 500 MB storage

**Häufigste Lösungen**:

1. Installiere [Visual C++ Redistributable](https://aka.ms/vs/17/release/vc_redist.x86.exe)**Recommended**:

2. Installiere [DirectX](https://www.microsoft.com/download/details.aspx?id=35)- Windows 10/11

3. Führe als Administrator aus- 4 GB RAM

4. Deaktiviere Antivirus temporär- 1 GB storage

5. Checke den **[Troubleshooting Guide](Troubleshooting)**

### Does it work on Mac/Linux?

### Kann ich meine Save Files sichern?Not officially, but you can try:

**Ja!** Save Files befinden sich in:- **Mac**: Use Wine or Parallels

````- **Linux**: Use Wine or PlayOnLinux

<Spiel-Ordner>/Save Files/

```### Why does Windows Defender flag the game?

Kopiere diesen Ordner zum Backup.False positive. The game is safe. This happens with RGSS games because:

- No digital signature

### Wie viele Save Slots gibt es?- Unpopular executable format

**6 Save Slots** (File A-F), plus Auto-Save Option.

**Solution**: Add exception in Windows Defender.

### Kann ich meinen Save zwischen Versionen übertragen?

**Meistens ja**, aber:### Can I play offline?

- **Minor Updates** (1.0.1 → 1.0.2): KompatibelYes! No internet connection required.

- **Major Updates** (1.0 → 2.0): Möglicherweise inkompatibel

### How do I update the game?

Backup deine Saves vor Updates!1. Download new version

2. Backup save files

---3. Extract new version

4. Copy save files back

## 🦋 Pokémon & Gameplay

See **[Installation Guide](Installation-Guide#-updating-to-new-version)** for details.

### Welche Pokémon sind verfügbar?

**Alle Pokémon Gen 1-9!** (~1000 Pokémon)---

- National Dex verfügbar

- Regional Forms## 🐛 Troubleshooting

- Neue Sound-Type Variants

### Game crashes on startup

Checke den **[Pokédex](Pokedex)** für Details!**Try these solutions**:

1. Run as Administrator

### Gibt es Shinies?2. Install [VC++ Redistributable](https://aka.ms/vs/17/release/vc_redist.x86.exe)

**Ja!** Shiny Rate: **1/4096** (Standard)3. Extract ALL files from ZIP

- **Shiny Charm**: 1/13654. Update graphics drivers

- **Masuda Method**: 1/683

- **Divine Shinies**: 1/65536 (ultra-rare Variante)### Black screen when starting

1. Update graphics drivers

Mehr im **[Shiny Hunting Guide](Shiny-Hunting)**!2. Run in compatibility mode (Windows 7)

3. Disable fullscreen optimizations

### Was ist der Sound-Type?

Ein **komplett neuer Pokémon-Typ** mit voller Integration:### Save file won't load

- 40+ neue Sound-Type Moves1. Navigate to game folder

- Eigene Type Effectiveness2. Delete `Save*.rxdata` files

- Sound-Type Gym & Legendary3. Start new game



Mehr im **[Sound Type Guide](Sound-Type)**!**Note**: Your save may be corrupted. Always keep backups!



### Kann ich alle Legendären fangen?### Missing DLL errors

**Ja!** Alle Legendären aus Gen 1-9 sind fangbar:Extract **all files** from the ZIP, not just `Game.exe`.

- **Story Legendaries**: Automatische Encounters

- **Post-Game Legendaries**: Hidden QuestsRequired files:

- **Event Legendaries**: Spezielle Events- `Game.exe`

- `RGSS104E.dll`

### Gibt es Mega Evolution / Dynamax / Z-Moves?- `Data/` folder

**JA, ALLES!**- `Graphics/` folder

- **Mega Evolution** (Gen 6)- `Audio/` folder

- **Z-Moves** (Gen 7)- All `.dll` files

- **Dynamax & Gigantamax** (Gen 8)

- **Terastallization** (Gen 9)---



Alle Mechaniken sind verfügbar und funktionieren zusammen!## 🔌 Plugins



### Wie funktioniert EV/IV Training?### What plugins are included?

- **IVs**: Zuchtsystem mit Destiny Knot, etc.See **[Plugin System](Plugin-System)** for complete list.

- **EVs**: Traditional EV Training + Vitamins

- **Bottle Caps**: Hyper Training (Post-Game)### Can I add my own plugins?

- **Nature Mints**: Change Natures (Post-Game)Yes! Place them in `Plugins/` folder.



Mehr im **[Breeding Guide](Breeding-Guide)**!**Requirements**:

- Ruby file (`.rb`)

### Gibt es Hidden Abilities?- Compatible with v21.1

**Ja!** Erhältlich durch:- Proper metadata comments

- Raid Battles (100% HA Rate)

- Hidden Grottos### How do I disable a plugin?

- Special Encounters1. Navigate to `Plugins/` folder

- Ability Patch (Post-Game Item)2. Rename plugin file: `plugin.rb` → `plugin.rb.disabled`

3. Restart game

---

### Are plugins updated automatically?

## 📜 Story & EventsNo, manual update required. Check our **[Releases](https://github.com/99Problemsx/test-stuff/releases)**.



### Wie viele Enden gibt es?---

**4 Hauptenden**:

1. **True Hero Path** - Canonical "good" ending## 🛠️ Development

2. **Divine Path** - Neutral ending

3. **Chaos Path** - "Bad" ending### Can I contribute?

4. **True Ending** - Secret perfect endingYes! See **[Contributing Guide](Contributing)**.



Deine Entscheidungen im Spiel beeinflussen das Ende!### How do I report bugs?

1. Check existing **[Issues](https://github.com/99Problemsx/test-stuff/issues)**

### Kann ich Entscheidungen rückgängig machen?2. Create new issue with:

**Nein**, aber:   - Clear title

- Multiple Save Slots erlauben verschiedene Pfade   - Steps to reproduce

- Post-Game "Chapter Select" nach erstem Durchgang   - Screenshots/error messages

- New Game+ Modus geplant   - System info



### Wie beeinflusst meine Starter-Wahl das Spiel?### How do I suggest features?

- **Dialog Variationen**Open an **[Issue](https://github.com/99Problemsx/test-stuff/issues/new)** with label "enhancement".

- **Certain Event Triggers**

- **Team Divine Interactions** (abhängig vom Starter)### What IDE do you recommend?

- **VS Code** (recommended)

Aber keine großen Story-Branches!- RubyMine

- Sublime Text

### Wann beginnt Post-Game Content?- Notepad++

Nach Besiegen des Champions, aber die **wahre Story** beginnt danach erst richtig!

### How does CI/CD work?

Post-Game includes:See **[CI/CD Pipeline](CI-CD-Pipeline)** documentation.

- 20+ zusätzliche Story-Stunden

- Alle Legendaries fangbar---

- Battle Facilities

- Dimension Dungeons## 📦 Releases

- True Ending Quest

### How often are releases?

---- **Hotfixes**: As needed (critical bugs)

- **Minor updates**: Monthly

## ⚔️ Kämpfe & Strategie- **Major updates**: Quarterly



### Wie schwer ist das Spiel?Follow **[Releases](https://github.com/99Problemsx/test-stuff/releases)** for notifications.

**3 Difficulty Settings**:

- **Easy**: Für Story-Fokus### What's the difference between versions?

- **Normal**: Balanced (Standard)We use **[Semantic Versioning](https://semver.org/)**:

- **Hard**: Challenge für Veterans- `v1.0.X` - Patch (bug fixes)

- `v1.X.0` - Minor (new features)

Schwierigkeit kann jederzeit geändert werden!- `vX.0.0` - Major (breaking changes)



### Gibt es Level-Caps?### Where can I download old versions?

**Ja** (optional in Settings):All versions available at **[Releases](https://github.com/99Problemsx/test-stuff/releases)**.

- Vor jedem Gym Leader

- Verhindert Overleveling### How are releases created?

- Kann deaktiviert werdenAutomatically via GitHub Actions when we push a tag:

```bash

### Kann ich gegen Gym Leaders erneut kämpfen?git tag v1.0.5

**Ja!** Nach Post-Game:git push origin v1.0.5

- Alle Gym Leader rematchable```

- Höhere Levels (80+)

- Bessere Rewards---



### Was ist die beste Team-Komposition?## 🌐 Community

Abhängig von deinem Spielstil, aber generell:

- **Diverse Types**: Decke viele Typen ab### Is there a Discord server?

- **Balanced Stats**: Mix aus Offense/DefenseNot yet, but planned! Check **[Discussions](https://github.com/99Problemsx/test-stuff/discussions)**.

- **Coverage Moves**: Super-effective gegen viele Typen

### How can I help?

Checke **[Competitive Guide](Competitive-Guide)** für Details!- Report bugs

- Suggest features

### Wo finde ich [bestimmtes Pokémon]?- Contribute code

Nutze den **[Pokédex Guide](Pokedex)** mit:- Improve documentation

- Location Data- Share the project

- Encounter Rates

- Time of Day### Can I use this in my project?

- Weather RequirementsCheck Pokemon Essentials license at **[PokéCommunity](https://www.pokemoncommunity.com/)**.



------



## 🎨 Customization & Features## 📄 Legal



### Kann ich meinen Charakter anpassen?### Is this official Pokemon?

**Ja!**No. This is a fan-made project using Pokemon Essentials.

- **Character Creation**: Name, Gender, Aussehen

- **Salons**: Hairstyle & Color ändern (in großen Städten)### Can I monetize this?

- **Boutiques**: 50+ Outfits kaufen**No.** Pokemon is a trademark of Nintendo/Game Freak.

- **Accessories**: Hüte, Brillen, etc.

### Are you affiliated with Nintendo?

### Gibt es eine Secret Base?**No.** This is an independent fan project.

**Ja!** Freischaltbar im Post-Game:

- 100+ Möbelstücke### Can I distribute this?

- Personalisiere deine BaseLink to our **[Releases](https://github.com/99Problemsx/test-stuff/releases)** page. Don't re-upload.

- NPCs einladen

- Base Battle System---



### Kann ich UI/HUD anpassen?## 🔄 Updates & Changelogs

**Ja!**

- 10+ UI Themes### Where can I see what changed?

- Text Size Options- **[CHANGELOG_AUTO.md](https://github.com/99Problemsx/test-stuff/blob/main/CHANGELOG_AUTO.md)** - Auto-generated

- Battle Speed (1x/2x/4x)- **[Release Notes](https://github.com/99Problemsx/test-stuff/releases)** - Manual summaries

- Colorblind Modes

- Custom Keybinds### How do I know about new releases?

1. **Watch** the repository (top right on GitHub)

Alles in **Settings → Options**!2. Choose "Releases only"

3. Get email notifications

### Gibt es Auto-Save?

**Ja** (optional):Or follow via **[RSS](https://github.com/99Problemsx/test-stuff/releases.atom)**.

- Auto-Save alle 5 Minuten

- Aktiviere in Settings---

- Empfohlen!

## 🎯 Performance

---

### Game runs slowly

## 🌐 Updates & Community**Try these**:

1. Close other programs

### Wie oft gibt es Updates?2. Update graphics drivers

- **Bug Fixes**: Nach Bedarf3. Run in windowed mode

- **Minor Updates**: Monatlich4. Disable unused plugins

- **Major Updates**: Quartalsweise

- **Content Updates**: Bei neuen Features### High CPU usage

Normal for RGSS games. Try:

Checke [GitHub Releases](https://github.com/99Problemsx/Zorua-the-divine-deception/releases)!1. Lower priority in Task Manager

2. Disable background apps

### Wie kann ich Bugs reporten?3. Check for malware

[GitHub Issues](https://github.com/99Problemsx/Zorua-the-divine-deception/issues)

### Large file size

Bitte include:Pokemon Essentials games are 300-500 MB due to:

- Beschreibung des Bugs- Graphics (sprites, tilesets)

- Steps to Reproduce- Audio (music, sound effects)

- Screenshots (wenn möglich)- Game data (PBS files)

- errorlog.txt aus dem Spiel-Ordner

---

### Kann ich zum Spiel beitragen?

**Ja!** Wir freuen uns über:## 🆘 Still Need Help?

- Bug Reports

- Feature SuggestionsCan't find your answer?

- Code Contributions

- Translations1. Check **[Troubleshooting](Troubleshooting)** guide

- Sprites/Graphics2. Search **[Issues](https://github.com/99Problemsx/test-stuff/issues)**

3. Create new issue

Lies **[Contributing Guide](Contributing)** für Details!4. Join **[Discussions](https://github.com/99Problemsx/test-stuff/discussions)**



### Gibt es einen Discord/Community?---

Aktuell nur [GitHub Discussions](https://github.com/99Problemsx/Zorua-the-divine-deception/discussions).

## 📝 Contributing to FAQ

Discord Server ist geplant!

Found a question that should be here?

---1. Open an **[Issue](https://github.com/99Problemsx/test-stuff/issues/new)**

2. Label it "documentation"

## 🎯 Achievements & Completion3. Suggest the Q&A



### Gibt es ein Achievement System?---

**Ja!** 200+ Achievements:

- Story Achievements[⬅ Back to Home](Home) | [➡ Next: Troubleshooting](Troubleshooting)

- Battle Achievements
- Collection Achievements
- Hidden Achievements

Checke Trainer Card → Achievements!

### Was ist 100% Completion?
- ✅ Alle 8 Badges
- ✅ Champion besiegt
- ✅ National Dex completed (alle gesehen)
- ✅ Alle Legendaries gefangen
- ✅ True Ending erreicht
- ✅ Alle Side Quests
- ✅ All Battle Facilities completed
- ✅ Alle Achievements (optional)

### Gibt es Rewards für 100%?
**Ja!**
- **Shiny Charm** (nach National Dex)
- **Divine Blessing** (nach True Ending)
- **Special Title** (100% Achievement)
- **Secret Trainer Battle** (Lv. 100 Team)

---

## 🔧 Advanced

### Kann ich das Spiel modden?
**Ja!** Das Spiel basiert auf Pokémon Essentials:
- Scripts sind zugänglich
- PBS Files editierbar
- Custom Sprites möglich

Mehr im **[Development Guide](Development-Setup)**!

### Gibt es Developer Tools?
**Ja!** Debug Mode:
- F1 im Spiel (Debug Mode)
- Teleport zu jedem Ort
- Spawn beliebige Pokémon
- Test Features

Nur für Development/Testing!

### Wie funktioniert das PBS Data System?
Das Spiel nutzt ein advanced **PBS Data System** für:
- Ruby-based Data Files
- Auto-Generation von .dat Files
- Hot-Reloading (Development)

Mehr in **[PBS Data System Docs](../docs/plugins/PBS-Data-System.md)**!

---

## 🐛 Known Issues

### Bekannte Bugs in aktueller Version?
Checke [GitHub Issues](https://github.com/99Problemsx/Zorua-the-divine-deception/issues) für:
- Aktive Bugs
- Workarounds
- Fix Status

### Performance Probleme?
**Lösungen**:
1. Reduce Battle Animations (Settings)
2. Lower Battle Speed
3. Disable Weather Effects
4. Update Graphics Drivers
5. Checke **[Troubleshooting](Troubleshooting)**

---

## 🎓 Tipps für Anfänger

### Top 10 Tipps für neue Spieler:

1. **Heile regelmäßig** - Pokécenter sind kostenlos!
2. **Diverse Team Types** - Decke viele Typen ab
3. **Rede mit NPCs** - Viele geben Items/Hints
4. **Erkunde alles** - Versteckte Items überall
5. **Speichere oft** - Oder aktiviere Auto-Save
6. **Type Effectiveness lernen** - Critical für Kämpfe
7. **Fange viele Pokémon** - Für Dex und Optionen
8. **Nutze Status Moves** - Nicht nur Damage Moves!
9. **Items sparen** - Heile im Center wenn möglich
10. **Hab Spaß!** - Keine Eile, genieße die Story

### Wo finde ich mehr Hilfe?
- 📚 **[Wiki Home](Home)** - Alle Guides
- 🎮 **[Getting Started](Getting-Started)** - Anfänger Guide
- 🐛 **[Troubleshooting](Troubleshooting)** - Problem Solving
- 💬 **[GitHub Discussions](https://github.com/99Problemsx/Zorua-the-divine-deception/discussions)** - Community

---

## ❓ Deine Frage ist nicht dabei?

### Wo kann ich weitere Fragen stellen?
- **[GitHub Discussions](https://github.com/99Problemsx/Zorua-the-divine-deception/discussions)** - Community Q&A
- **[GitHub Issues](https://github.com/99Problemsx/Zorua-the-divine-deception/issues)** - Bug Reports

### Wie kontaktiere ich die Entwickler?
- GitHub Issues für Bugs
- GitHub Discussions für Fragen
- GitHub Pull Requests für Contributions

---

<div align="center">

*"Die Antwort die du suchst, könnte selbst eine Täuschung sein."*

**Weitere Fragen? Stelle sie in den [GitHub Discussions](https://github.com/99Problemsx/Zorua-the-divine-deception/discussions)!**

[⬆ Back to Wiki Home](Home.md)

</div>
````
