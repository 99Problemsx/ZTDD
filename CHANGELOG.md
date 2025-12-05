# Changelog

Alle wichtigen Änderungen an diesem Projekt werden in dieser Datei dokumentiert.

Das Format basiert auf [Keep a Changelog](https://keepachangelog.com/de/1.0.0/),
und dieses Projekt folgt [Semantic Versioning](https://semver.org/lang/de/).

## [Unreleased]

### Added

- PBS Data System - Ruby-basierte PBS-Dateien statt Textdateien
- Wind Animation System mit map-relativer Positionierung
- Auto-Generation für fehlende .dat Dateien
- Alle Gen 1-9 Pokemon in Ruby-Klassen

### Changed

- PBS/Data/ Struktur umgestellt auf Gen-basierte Organisation
- Compiler Override für DBK Plugins
- EventHandlers für on_game_start hinzugefügt

### Fixed

- Wind Animation Geschwindigkeit mit Frame-Rate-Kompensation
- GameData.load_data Override für fehlende Dateien
- `evolutions` Alias für `evolution` Methode

## [0.1.0] - 2025-10-27

### Added

- Initiales Projekt-Setup
- Pokémon Essentials v21.1 Integration
- v21.1 Hotfixes 1.0.9
- MKXP-Z Engine Support
- DBK Plugin Suite (Dynamax, Tera, Z-Power, Raids)
- Luka's Scripting Utilities
- Following Pokemon EX
- Arcky's Region Map
- Challenge Modes Plugin

### Documentation

- README.md erstellt
- CONTRIBUTING.md hinzugefügt
- CODE_OF_CONDUCT.md hinzugefügt
- Plugin-Dokumentation begonnen

---

## Versioning Guide

- **MAJOR** (X.0.0): Breaking Changes, inkompatible API-Änderungen
- **MINOR** (0.X.0): Neue Features, abwärtskompatibel
- **PATCH** (0.0.X): Bug Fixes, abwärtskompatibel

## Change Categories

- `Added` - Neue Features
- `Changed` - Änderungen an bestehenden Features
- `Deprecated` - Bald zu entfernende Features
- `Removed` - Entfernte Features
- `Fixed` - Bug Fixes
- `Security` - Sicherheits-Fixes
