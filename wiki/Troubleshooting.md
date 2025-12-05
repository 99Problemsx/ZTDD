# 🐛 Troubleshooting - Pokémon Zorua: The Divine Deception

Probleme mit dem Spiel? Hier findest du Lösungen!

---

## 🚨 Häufigste Probleme

### 🎮 Spiel startet nicht

#### Problem: Game.exe öffnet nicht / Sofort Crash

**Lösungen**:

1. **Installiere Visual C++ Redistributable**

   - Download: [VC++ Redist x86](https://aka.ms/vs/17/release/vc_redist.x86.exe)
   - Installiere und starte PC neu

2. **Installiere DirectX**

   - Download: [DirectX End-User Runtime](https://www.microsoft.com/download/details.aspx?id=35)
   - Installiere und starte PC neu

3. **Führe als Administrator aus**

   - Rechtsklick auf `Game.exe`
   - "Als Administrator ausführen"

4. **Deaktiviere Antivirus temporär**

   - Manche Antivirusprogramme blockieren RPG Maker Games
   - Füge Spiel-Ordner zu Ausnahmen hinzu

5. **Checke Windows Defender**
   ```powershell
   # PowerShell als Admin:
   Add-MpPreference -ExclusionPath "C:\Pfad\zum\Spiel"
   ```

#### Problem: "RGSS-RTP Standard not found" Error

**Lösung**: Du brauchst KEINE RTP! Das Spiel ist standalone.

Wenn Error trotzdem erscheint:

- Lösche `Game.ini` und starte neu
- Oder: Download [RPG Maker XP RTP](https://www.rpgmakerweb.com/download/additional/run-time-packages) (optional)

---

### 💾 Save File Probleme

#### Problem: Kann nicht speichern / "Failed to save" Error

**Lösungen**:

1. **Checke Ordner-Permissions**

   - Rechtsklick auf Spiel-Ordner
   - Eigenschaften → Sicherheit
   - Stelle sicher du hast "Vollzugriff"

2. **Führe als Administrator aus**

   - Siehe oben

3. **Antivirus blockiert Saves**

   - Füge `Save Files/` Ordner zu Ausnahmen hinzu

4. **Zu wenig Speicherplatz**
   - Checke verfügbaren Speicher (min. 100 MB frei)

#### Problem: Save File korrupt / Lädt nicht

**Lösungen**:

1. **Nutze Backup Save**

   ```
   Save Files/
   ├── Game.rxdata      ← Hauptsave
   └── Game.rxdata.bak  ← Backup (wenn vorhanden)
   ```

   - Benenne `.bak` zu `.rxdata` um

2. **Auto-Save Recovery**

   ```
   Save Files/
   └── AutoSave_Game.rxdata
   ```

   - Kopiere Auto-Save als Hauptsave

3. **Wenn alles fehlschlägt**
   - Starte neues Spiel
   - Nutze Debug Mode (F1) um Progress zu recovern
   - Oder: Frage in [GitHub Issues](https://github.com/99Problemsx/Zorua-the-divine-deception/issues) nach Hilfe

---

### 🖥️ Performance Probleme

#### Problem: Spiel laggt / Niedrige FPS

**Lösungen**:

1. **Reduziere Battle Animations**

   - Menu → Settings → Battle Effects → OFF

2. **Reduziere Battle Speed**

   - Settings → Battle Speed → 1x

3. **Deaktiviere Weather Effects**

   - Settings → Show Weather → OFF

4. **Schließe andere Programme**

   - Browser, Discord, etc.

5. **Update Graphics Drivers**

   - NVIDIA: [GeForce Experience](https://www.nvidia.com/de-de/geforce/geforce-experience/)
   - AMD: [Radeon Software](https://www.amd.com/de/support)
   - Intel: [Driver & Support Assistant](https://www.intel.de/content/www/de/de/support/detect.html)

6. **Setze Windows Power Mode auf "Leistung"**
   - Windows Settings → System → Netzbetrieb

#### Problem: Audio Stuttering / Crackling

**Lösungen**:

1. **Update Audio Drivers**

   - Geräte-Manager → Audiogeräte → Update

2. **Ändere Audio Settings**

   - Rechtsklick Lautsprecher-Icon (Taskbar)
   - Sounds → Wiedergabe → Eigenschaften
   - Erweitert → Qualität auf 44100 Hz setzen

3. **Deaktiviere Audio Enhancements**
   - Selbes Menü → "Alle Soundeffekte deaktivieren"

---

### 🎮 Gameplay Bugs

#### Problem: Stuck in Terrain / Kann nicht bewegen

**Lösungen**:

1. **Soft-Reset**

   - Drücke `F12` (Reset Spiel)
   - Lädt letzten Save

2. **Debug Mode Teleport**

   - Drücke `F1` (Debug Menu)
   - "Teleport" → Wähle Location
   - **Warnung**: Nur als letzter Ausweg!

3. **Lade alten Save**
   - Main Menu → Load
   - Wähle früheren Save Slot

#### Problem: NPC verschwindet / Event triggert nicht

**Lösungen**:

1. **Verlasse und betrete Map erneut**

   - Events reset oft beim Map-Wechsel

2. **Checke Story-Requirements**

   - Manche Events brauchen spezifische Story-Progress
   - Checke **[Story Overview](Story-Overview)**

3. **Rede mit anderen NPCs**

   - Manche Events brauchen vorherige Events

4. **Time-of-Day abhängig**
   - Manche NPCs erscheinen nur Tag/Nacht
   - Warte oder nutze Bed (in Pokécenter) um Zeit zu ändern

#### Problem: Pokémon entwickelt sich nicht

**Checke Requirements**:

| Problem             | Lösung                                            |
| ------------------- | ------------------------------------------------- |
| Level-up Evolution  | Muss im Kampf leveln (nicht Rare Candy)           |
| Stone Evolution     | Nutze richtigen Stone aus Bag                     |
| Trade Evolution     | Nutze "Link Cable" Item (ab Version 1.0)          |
| Happiness Evolution | Erhöhe Happiness (Massage, Battles, Berries)      |
| Time Evolution      | Tag/Nacht abhängig                                |
| Location Evolution  | Bestimmter Ort nötig (z.B. Moss Rock für Leafeon) |
| Move Evolution      | Pokémon muss bestimmte Move kennen                |

Checke **[Pokédex](Pokedex)** für spezifische Evolution Requirements!

#### Problem: Shiny funktioniert nicht / Sieht normal aus

**Lösungen**:

1. **Checke Party/Box**

   - Öffne Summary
   - Shiny hat ⭐ Symbol

2. **Graphics Cache löschen**

   ```
   <Spiel-Ordner>/Graphics/
   └── [Keine .cache Dateien löschen - sie regenerieren]
   ```

3. **Reinstall Spiel**
   - Backup deine Saves!
   - Download neue Version

---

### 🖼️ Grafik Probleme

#### Problem: Schwarzer Bildschirm / Graphics fehlen

**Lösungen**:

1. **Reextract ZIP richtig**

   - Manche Dateien fehlen bei fehlerhaftem Extract
   - Nutze Windows "Alle extrahieren" statt WinRAR/7zip

2. **Checke Graphics Ordner**

   ```
   Graphics/
   ├── Characters/
   ├── Battlebacks/
   ├── Battlers/
   └── ...
   ```

   - Alle Ordner sollten Dateien enthalten

3. **Update DirectX**
   - Siehe oben unter "Spiel startet nicht"

#### Problem: Sprites/Textures fehlen

**Lösungen**:

1. **Verify File Integrity**

   - Redownload von GitHub
   - Checke ob ZIP vollständig heruntergeladen

2. **Graphics Cache löschen**
   - Lösche alle `.cache` Dateien im Spiel-Ordner

---

### ⚔️ Battle Bugs

#### Problem: Battle freezt / Hängt

**Lösungen**:

1. **Skip Animations**

   - Settings → Battle Animations → OFF

2. **Reduce Battle Speed**

   - Settings → Battle Speed → 1x

3. **Bestimmte Move verursacht Crash?**
   - Notiere Move Name
   - Reporte in [GitHub Issues](https://github.com/99Problemsx/Zorua-the-divine-deception/issues)
   - Workaround: Nutze andere Move

#### Problem: Mega Evolution / Dynamax funktioniert nicht

**Checke Requirements**:

**Mega Evolution**:

- ✅ Pokémon kann Mega-Evolvieren
- ✅ Hat Mega Stone im Held Item
- ✅ Du hast Mega Ring (Story Item)
- ✅ Drücke richtige Taste im Battle (Shift/C)

**Dynamax**:

- ✅ In Dynamax-fähigem Gebiet (Power Spots)
- ✅ Einmal pro Battle
- ✅ Select "Dynamax" im Fight Menu

**Z-Moves**:

- ✅ Pokémon hat Z-Crystal
- ✅ Z-Move-fähige Attack
- ✅ Einmal pro Battle
- ✅ Drücke richtige Taste

---

## 🔧 Advanced Troubleshooting

### Error Log analysieren

Bei Crashes: Checke `errorlog.txt` im Spiel-Ordner.

**Häufige Errors**:

#### Error: "undefined method for nil:NilClass"

```ruby
Script 'XXX' line YYY: NoMethodError occurred.
undefined method 'something' for nil:NilClass
```

**Bedeutung**: Script versucht auf nicht-existente Daten zuzugreifen

**Lösung**:

- Reporte mit genauem Error in [GitHub Issues](https://github.com/99Problemsx/Zorua-the-divine-deception/issues)
- Include `errorlog.txt`

#### Error: "File not found"

```ruby
Errno::ENOENT
No such file or directory - PBS/pokemon.txt
```

**Bedeutung**: Spielfile fehlt

**Lösung**:

- Reinstall Spiel
- Checke ob alle Dateien extrahiert wurden

#### Error: "Stack level too deep"

```ruby
SystemStackError occurred.
stack level too deep
```

**Bedeutung**: Infinite Loop im Script (Bug)

**Lösung**:

- Reporte Bug mit Steps to Reproduce
- Lade früheren Save vor dem Bug

---

### Debug Mode nutzen (für Notfälle)

**⚠️ Warnung**: Nur nutzen wenn absolut nötig! Kann Saves korrumpieren!

#### Debug Menu öffnen:

Drücke `F1` im Spiel

#### Nützliche Debug Commands:

- **Teleport**: Gehe zu jedem Ort
- **Heal Party**: Sofort heilen
- **Add Pokémon**: Spawne jedes Pokémon
- **Change Switches**: Toggle Story Events
- **Change Variables**: Edit Game Variables

#### Debug Mode deaktivieren:

Edit `mkxp.json`:

```json
{
  "debugMode": false
}
```

---

## 🆘 Wenn nichts funktioniert

### Kompletter Reinstall

1. **Backup Saves**

   ```
   Save Files/ → Kopiere gesamten Ordner
   ```

2. **Lösche Spiel-Ordner**

3. **Redownload von GitHub**

   - [Latest Release](https://github.com/99Problemsx/Zorua-the-divine-deception/releases/latest)

4. **Extract erneut**

5. **Restore Saves**

   ```
   Kopiere Save Files/ zurück
   ```

6. **Starte Spiel**

### Noch immer Probleme?

#### 1. Sammle Informationen:

- Windows Version
- Spiel Version
- `errorlog.txt` Inhalt
- Steps to Reproduce
- Screenshots (wenn möglich)

#### 2. Reporte Issue:

[Create GitHub Issue](https://github.com/99Problemsx/Zorua-the-divine-deception/issues/new)

**Template**:

```markdown
**Bug Beschreibung:**
[Was ist passiert?]

**Steps to Reproduce:**

1.
2.
3.

**Expected Behavior:**
[Was sollte passieren?]

**Screenshots:**
[Wenn vorhanden]

**System Info:**

- OS: Windows 10
- Spiel Version: v1.0.0
- Error Log: [Paste hier]

**Zusätzliche Info:**
[Alles relevante]
```

#### 3. Community fragen:

[GitHub Discussions](https://github.com/99Problemsx/Zorua-the-divine-deception/discussions)

---

## 📚 Weitere Hilfe

### Related Pages

- ❓ **[FAQ](FAQ)** - Häufige Fragen
- 🎮 **[Getting Started](Getting-Started)** - Anfänger Guide
- ⚙️ **[Settings Guide](Settings-Options)** - Optionen erklärt
- 📖 **[Wiki Home](Home)** - Alle Guides

### Externe Resources

- **RPG Maker XP**: [Official Site](https://www.rpgmakerweb.com/)
- **Pokémon Essentials**: [Wiki](https://essentialsdocs.fandom.com/)
- **Community**: [GitHub Discussions](https://github.com/99Problemsx/Zorua-the-divine-deception/discussions)

---

<div align="center">

**🛠️ Problem gelöst? Awesome! Wenn nicht, zögere nicht zu fragen! 🛠️**

_"Manchmal ist die Lösung selbst eine Täuschung... aber hoffentlich nicht hier!"_

[⬆ Back to Wiki Home](Home.md)

</div>
