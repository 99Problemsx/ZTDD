# 🚀 Release Process

Dieser Leitfaden beschreibt den Release-Prozess für Pokémon Zorua - The Divine Deception.

## 📋 Release Typen

### Major Release (v1.0.0 → v2.0.0)
- **Breaking Changes**: Inkompatible API-Änderungen
- **Save-Breaking**: Alte Spielstände funktionieren nicht mehr
- **Feature**: Große neue Features (neue Region, neue Mechanik)

### Minor Release (v1.0.0 → v1.1.0)
- **Features**: Neue Features ohne Breaking Changes
- **Plugins**: Neue Plugin-Integrationen
- **Content**: Neue Pokémon, Moves, Items

### Patch Release (v1.0.0 → v1.0.1)
- **Bugfixes**: Fehler beheben
- **Performance**: Performance-Verbesserungen
- **Documentation**: Dokumentations-Updates

## 🔄 Automatischer Release-Prozess

### Conventional Commits

Unser Projekt verwendet [Conventional Commits](https://www.conventionalcommits.org/) für automatische Releases:

```bash
# Patch Release (1.0.0 → 1.0.1)
git commit -m "fix: Correct damage calculation for critical hits"

# Minor Release (1.0.0 → 1.1.0)
git commit -m "feat: Add Mega Evolution support"

# Major Release (1.0.0 → 2.0.0)
git commit -m "feat!: Rewrite battle system

BREAKING CHANGE: Battle API completely changed"
```

### Automatische Version-Bumps

Der `auto-release.yml` Workflow bumpt automatisch die Version:

1. **Commits analysieren** (letzte 5 Commits)
2. **Version bestimmen**:
   - `feat:` → Minor bump (v1.0.0 → v1.1.0)
   - `fix:` → Patch bump (v1.0.0 → v1.0.1)
   - `BREAKING CHANGE` → Major bump (v1.0.0 → v2.0.0)
3. **Changelog generieren**
4. **Package erstellen**
5. **GitHub Release erstellen**

## 📦 Release Checklist

### Vor dem Release

- [ ] Alle Tests laufen durch
- [ ] Keine offenen Critical Bugs
- [ ] Dokumentation ist aktuell
- [ ] CHANGELOG.md ist vorbereitet
- [ ] Version-Nummer ist korrekt

### Release erstellen

#### Option 1: Automatisch (Empfohlen)

```bash
# 1. Main Branch aktualisieren
git checkout main
git pull origin main

# 2. Änderungen committen (mit Conventional Commits)
git add .
git commit -m "feat: Add new battle feature"

# 3. Push - Workflow startet automatisch
git push origin main
```

Der Workflow:
1. Analysiert Commits
2. Erstellt neuen Tag
3. Generiert Changelog
4. Erstellt Release-Package
5. Uploaded zu GitHub Releases

#### Option 2: Manuell

```bash
# 1. Version Tag erstellen
git tag v1.2.0

# 2. Tag pushen - triggert Release-Workflow
git push origin v1.2.0
```

### Nach dem Release

- [ ] Release Notes in GitHub veröffentlichen
- [ ] Discord/Community benachrichtigen
- [ ] Wiki aktualisieren
- [ ] Milestone schließen (falls vorhanden)

## 📝 Release Notes Template

```markdown
## Zorua: The Divine Deception v1.2.0

### ✨ New Features
- Add Mega Evolution support for 50+ Pokémon
- New Battle Frontier area with 7 facilities
- Implement Rotation Battles

### 🐛 Bug Fixes
- Fix crash when using Baton Pass with certain moves
- Correct Dynamax HP calculation
- Fix Raid Battle reward distribution

### 🔧 Other Changes
- Improve battle animation performance
- Update German translations
- Refactor PBS loading system

### 📦 Installation
1. Download `Zorua-The-Divine-Deception-v1.2.0-Windows.zip`
2. Extract the ZIP file
3. Run `Game.exe`

### ⚠️ Breaking Changes
None - This release is fully compatible with v1.1.x save files

### 🙏 Credits
- @contributor1 for Mega Evolution sprites
- @contributor2 for Battle Frontier design
- Essentials Team for framework updates

---

**Full Changelog**: https://github.com/99Problemsx/ZTDD/compare/v1.1.0...v1.2.0
```

## 🎯 Version Numbering

Wir folgen [Semantic Versioning](https://semver.org/):

```
v MAJOR . MINOR . PATCH
  │       │       │
  │       │       └─ Bugfixes, kleine Änderungen
  │       └───────── Neue Features (backward compatible)
  └───────────────── Breaking Changes
```

### Beispiele

- `v1.0.0` → Initial Release
- `v1.0.1` → Bugfix (Raid Battle crash)
- `v1.1.0` → New Feature (Mega Evolution)
- `v2.0.0` → Breaking Change (New Save Format)

## 🔧 Release Workflow

### Workflow-Trigger

```yaml
on:
  push:
    branches: [main]
    tags: ['v*']
```

Wird ausgelöst bei:
- Push zu `main` Branch
- Tag mit `v` Prefix (z.B. `v1.0.0`)

### Release Artifacts

Der Workflow erstellt:

1. **Game Package**: `Zorua-The-Divine-Deception-v1.0.0-Windows.zip`
   - Alle Game-Dateien
   - Plugins
   - Graphics/Audio
   - DLLs

2. **Changelog**: `changelog.json`
   - Machine-readable format
   - Für Launcher/Updater

3. **VERSION.txt**: Version-String
   - Zur Laufzeit-Prüfung

### Package-Inhalt

```
Zorua-The-Divine-Deception-v1.0.0-Windows.zip
├── Audio/
├── Data/
├── Fonts/
├── Graphics/
├── PBS/
├── Plugins/
├── Text_deutsch_core/
├── Text_deutsch_game/
├── Game.exe
├── Game.ini
├── mkxp.json
├── soundfont.sf2
├── *.dll
└── VERSION.txt
```

## 🐛 Hotfix Process

Für kritische Bugs nach Release:

```bash
# 1. Hotfix Branch erstellen
git checkout -b hotfix/v1.0.1 v1.0.0

# 2. Fix committen
git commit -m "fix: Critical battle crash"

# 3. Merge zu main
git checkout main
git merge hotfix/v1.0.1

# 4. Tag erstellen
git tag v1.0.1

# 5. Push
git push origin main v1.0.1
```

## 📊 Release Metriken

Nach jedem Release tracken:

- Download-Zahlen
- Bug-Reports
- User-Feedback
- Performance-Metriken

Siehe `track-downloads.yml` Workflow für automatisches Tracking.

## 🔐 Security Releases

Bei Security-Fixes:

1. **Privat** fix entwickeln
2. Security Advisory erstellen
3. Fix releasen
4. Advisory veröffentlichen

## 📅 Release Schedule

### Regular Releases
- **Patch**: Bei Bedarf (Bugfixes)
- **Minor**: Monatlich (neue Features)
- **Major**: Halbjährlich (große Updates)

### Special Releases
- **Hotfix**: Sofort (kritische Bugs)
- **Beta**: Wöchentlich (für Tester)

## 🎓 Best Practices

### DO ✅
- Conventional Commits verwenden
- Tests vor Release durchführen
- Changelog pflegen
- Breaking Changes dokumentieren
- Backwards Compatibility prüfen

### DON'T ❌
- Direkt auf main committen ohne Tests
- Breaking Changes in Patch Releases
- Releases ohne Changelog
- Untested Features releasen
- Version-Tags nachträglich ändern

## 🔗 Weitere Ressourcen

- [Semantic Versioning](https://semver.org/)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [Keep a Changelog](https://keepachangelog.com/)
- [GitHub Releases](https://docs.github.com/en/repositories/releasing-projects-on-github)

---

**Fragen?** Öffne eine [Discussion](https://github.com/99Problemsx/ZTDD/discussions)
