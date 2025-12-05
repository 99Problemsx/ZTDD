# Advanced AI System v3.0.0 (Reborn-Inspired)

**Master-Tier Pokémon-KI für Hardmode-Spieler**

Ein umfassendes KI-System für Pokémon Essentials v21.1, inspiriert von **Pokémon Reborn**, das Computer-Gegner dramatisch verbessert durch:
- **Move Memory System**: Trackt alle Gegner-Züge für intelligente Vorhersagen
- **Threat Assessment**: 10-Punkte-Skala Gefahrenbewertung (Stats, Moves, Abilities)
- **Switch-In Logik**: Intelligente Wechsel basierend auf Typ-Matchups, Rollen und Momentum
- **Role Detection**: 7 Pokemon-Rollen (Sweeper, Wall, Tank, Support, Wallbreaker, Pivot, Lead)
- **Field Effects**: Wetter, Terrain, Trick Room Awareness
- **Doubles Coordination**: Partner-Synergie, Overkill-Prevention, Spread Move Optimization
- **267+ Gen 1-9 Abilities**: Vollständige Ability-Analyse für Threat Assessment
- **900+ Move Categories**: Automatische Move-Kategorisierung (Priority, Setup, Hazards, etc.)
- **693 Items**: Intelligente Item-Nutzung (Choice items, Life Orb, Assault Vest, etc.)
- **Setup Recognition**: 5 Bewertungs-Systeme für Setup-Counter
- **Endgame Logic**: Spezielle 1v1/2v2 Strategien
- **Battle Personalities**: 4 verschiedene Spielstile (Aggressive, Defensive, Balanced, Hyper Offensive)
- **Prediction System**: Switch & Move Prediction basierend auf Patterns
- **Team Preview**: Optimale Lead-Auswahl basierend auf Matchups
- **18 verbundene Systeme**: Über 15.000 Codezeilen Master-Level-Intelligenz
- **Volle DBK-Kompatibilität**: Dynamax, Terastallization, Z-Moves, Raid Battles
- **Generation 9 Support**: Kompatibel mit Gen 9 Pack

---

## 🚀 Schnellstart

### Installation

1. Kopiere `[AAI_000] Advanced AI System` nach `Plugins/`
2. Das Plugin aktiviert sich automatisch (siehe Einstellungen)
3. Starte das Spiel - KI ist sofort verbessert!

### Basis-Konfiguration

```ruby
# In [001] Settings.rb
module AdvancedAI
  ENABLED = true                           # System an/aus
  MIN_SKILL_FOR_AUTO_ACTIVATION = 70      # Auto-Aktivierung ab Skill 70
  DEBUG_MODE = false                       # Debug-Logging
end
```

### Testen

```ruby
# Trainer mit Master-KI erstellen
pbTrainerBattle(:POKEMONTRAINER_Red, "Red", nil, false, 0, true, 100)
# Skill 100 = Alle Features inkl. Tera
```

---

## 🎯 Feature-Übersicht

### Kern-Systeme (Skill 50+) - Reborn-Inspired

**1. Settings & Core** ([001]-[002])
- Konfigurations-Management
- Skill-Level-System
- Challenge Mode Integration

**2. Move Scoring** ([003])
- 20+ Bewertungsfaktoren
- Schadens-Berechnung
- KO-Prediction

**3. Move Memory** ([007]) ⭐
- **Trackt alle Gegner-Moves**
- **Priority Move Detection**
- **Healing Move Detection**
- **Max Damage Calculation**
- **Move Frequency Tracking**

**4. Threat Assessment** ([008]) ⭐
- **10-Punkte-Skala** (0 = harmlos, 10 = extrem gefährlich)
- **Stat-basierte Bedrohung** (Atk/SpAtk vs Def/SpDef)
- **Typ-Matchup Bedrohung** (SE/NVE/Immune)
- **Move-basierte Bedrohung** (Priority, OHKO, Setup)
- **Ability-basierte Bedrohung** (Huge Power, Adaptability, etc.)
- **HP-Modifier** (schwache Gegner = niedrigere Bedrohung)
- **Setup-Bedrohung** (Stat Boosts erhöhen Gefahr)
- **Speed-Bedrohung** (schnellere Gegner = gefährlicher)

**5. Doubles Coordination** ([009]) ⭐
- **Overkill-Prevention** (-40 wenn Partner auch angreift)
- **Move Conflict Prevention** (kein doppeltes Screens/Hazards)
- **Spread Move Optimization** (EQ mit Levitate Partner)
- **Field Effect Coordination** (Weather für Partner-Ability)
- **Protect + Setup Combos** (Partner setuppt → Protect)

**6. Field Effects** ([010]) ⭐
- **Weather Awareness** (Rain +30 für Water, Sun +30 für Fire)
- **Terrain Awareness** (Electric Terrain +25, Grassy -20 für EQ)
- **Trick Room Logic** (bevorzugt langsame Pokemon)
- **Gravity Synergy** (Ground trifft Flying, OHKO 100% acc)
- **Room Effects** (Magic Room, Wonder Room)

**7. Role Detection** ([011]) ⭐
- **7 Pokemon-Rollen**:
  - Sweeper (Speed 100+, Atk/SpAtk 100+)
  - Wall (HP/Def/SpDef 300+, Speed <70)
  - Tank (HP 90+, Atk/SpAtk 100+, Speed <90)
  - Support (Screens, Hazards, Status moves)
  - Wallbreaker (Atk/SpAtk 120+)
  - Pivot (U-turn, Volt Switch, Flip Turn)
  - Lead (Hazard setter, Fast Taunt)
- **Counter-Play**: Wall → Wallbreaker, Sweeper → Wall
- **Best Pokemon für Rolle finden**

**8. Switch Intelligence** ([012]) ⭐
- **Typ-Matchup Analyse** (40 Punkte)
- **HP & Status Analyse** (30 Punkte)
- **Stat Stage Analyse** (25 Punkte)
- **Bessere Optionen** (35 Punkte)
- **Momentum Kontrolle** (20 Punkte)
- **Vorhersage-Bonus** (15 Punkte)
- **Rollen-basiertes Switching** (empfiehlt Counter-Rolle)

### DBK-Integration (Skill 95-100+)

**4. Dynamax Intelligence** ([022]) - **DBK_005**
- 6 Bewertungs-Systeme
- Strategisches Timing
- G-Max-Attacken-Optimierung
- HP-Boost-Analyse

**5. Terastallization Intelligence** ([023]) - **DBK_006**
- 6 Bewertungs-Systeme
- Typ-Vorteil-Analyse
- Sweep-Potential-Erkennung
- Survival-Necessity-Bewertung

---

## 🧠 Switch Intelligence - Herzstück

Die **Switch Intelligence** ist das Herzstück für Hardmode-Spieler:

### Wann wechselt die KI?

```
SWITCH SCORE = Typ-Nachteil + HP-Probleme + Stat-Senkungen + 
               Bessere Option - Momentum-Verlust - Setup-Verschwendung

Schwellenwerte:
Master  (Skill 100): 35+ Punkte → Switch
Expert  (Skill 90):  40+ Punkte → Switch
Advanced(Skill 80):  45+ Punkte → Switch
Core    (Skill 50):  50+ Punkte → Switch
```

### Evaluierungs-Faktoren

**1. Typ-Matchup (0-40 Punkte)**
```ruby
# Gegner hat sehr effektive Attacke → +15
# User trifft nicht sehr effektiv → +10
# Gegner hat STAB + super effective → +15
# Total: Bis zu 40 Punkte
```

**2. Überlebens-Bedenken (0-30 Punkte)**
```ruby
# HP < 25% → +30
# HP < 40% → +20
# HP < 55% → +10
# Keine Heilung + niedrige HP → +10
# Toxisch vergiftet → +20
# OHKO-Gefahr → +15
```

**3. Stat-Stages (0-25 Punkte)**
```ruby
# -1 Stat Stage → +8 pro Stage
# -2 Angriff (physical attacker) → +10
# -2 Speed → +12
# Gegner mit +4 Boosts → +10
```

**4. Bessere Option (0-35 Punkte)**
```ruby
# Deutlich besseres Matchup verfügbar → +35
# Gutes Matchup verfügbar → +25
# Leichtes Matchup → +15
```

**5. Momentum (0-20 Punkte)**
```ruby
# Team im Nachteil → +10
# Gegner will Setup → +15
```

**Malus-Faktoren:**
```ruby
# User hat Vorteil → -20
# User hat +2 Boosts → -20
# User hat +4 Boosts → -30
```

---

## 📊 Skill-Level-System

```
SKILL LEVEL → FEATURES

50+  → Kern-KI (Move Scoring, Threat Assessment, Switch Intelligence)
55+  → + Setup Recognition
60+  → + Endgame Scenarios
65+  → + Battle Personalities
85+  → + Item Intelligence + Prediction System
90+  → + Team Preview Intelligence
95+  → + Dynamax Intelligence (DBK_005)
100+ → + Terastallization (DBK_006) [MASTER-TIER]
```

### Empfohlene Skill-Level

```
Route-Trainer:      50-55  (Kern-KI)
Arena-Leiter:       60-75  (+ Setup & Endgame)
Top Vier:           80-90  (+ Items & Vorhersage)
Champion/Bosse:     95-100 (Alle Features)
Post-Game-Bosse:    100+   (Master-Tier mit Tera)
```

---

## 🎮 Verwendung

### Trainer-Definition

```ruby
# Standard-Trainer (Basic AI)
pbTrainerBattle(:YOUNGSTER, "Joey", nil, false, 0, true, 45)

# Kern-AI (Switch Intelligence aktiv)
pbTrainerBattle(:LEADER_Brock, "Rocko", nil, false, 0, true, 65)

# Experten-AI (Items + Prediction)
pbTrainerBattle(:LEADER_Giovanni, "Giovanni", nil, false, 0, true, 85)

# Master-AI (Dynamax Intelligence)
pbTrainerBattle(:CHAMPION_Cynthia, "Cynthia", nil, false, 0, true, 95)

# Master-AI mit Tera (Alle Features)
pbTrainerBattle(:CHAMPION_Red, "Red", nil, false, 0, true, 100)
```

### Event-Skripte

```ruby
# Manuell aktivieren/deaktivieren
AdvancedAI.activate!
AdvancedAI.deactivate!

# Prüfen ob aktiv
if AdvancedAI.active?
  pbMessage("Bereite dich auf einen harten Kampf vor!")
end

# Feature-Check
if AdvancedAI.feature_enabled?(:terastallization, 100)
  pbMessage("Der Gegner kann Terastallisieren!")
end
```

---

## 🔧 Konfiguration

### Skill-Schwellenwerte anpassen

```ruby
# In [001] Settings.rb
SKILL_THRESHOLDS = {
  :core              => 40,   # Niedriger = früher aktiv
  :setup             => 50,
  :endgame           => 55,
  :personalities     => 60,
  :items             => 80,
  :prediction        => 80,
  :team_preview      => 85,
  :dynamax           => 90,
  :terastallization  => 95    # Niedriger für mehr Tera-KI
}
```

### Advanced Flags (Feintuning)

```ruby
# Bit-Flags für granulare Kontrolle
ADVANCED_FLAGS = {
  :switch_prediction    => 0b00000001,  # Gegner-Switch vorhersagen
  :setup_chains         => 0b00000010,  # Baton Pass Chains
  :hazard_calc          => 0b00000100,  # Entry Hazards
  :weather_abuse        => 0b00001000,  # Wetter ausnutzen
  :terrain_abuse        => 0b00010000,  # Terrain ausnutzen
  :ko_prediction        => 0b00100000,  # KO vorhersagen
  :revenge_kill         => 0b01000000,  # Revenge Kill verhindern
  :momentum_control     => 0b10000000   # Momentum kontrollieren
}

# Alle aktivieren
DEFAULT_FLAGS = 0b11111111
```

### Debug-Modus

```ruby
DEBUG_MODE = true  # Detailliertes Logging

# Console Output:
# [AI] Switch score for Pikachu: 45
# [Switch] Best switch: Index 2 with score 65
# [Dynamax] Dynamax score for Charizard: 85
# [Tera] Tera score for Garchomp: 72
```

---

## 🔌 Kompatibilität

### Erforderlich
- Pokémon Essentials v21.1+
- Ruby 3.1+

### DBK Plugin Integration

✅ **DBK_000** - Deluxe Battle Kit (Core)  
✅ **DBK_002** - SOS Battles  
✅ **DBK_003** - Raid Battles  
✅ **DBK_004** - Z-Power (Z-Moves)  
✅ **DBK_005** - Dynamax ⭐ (Skill 95+)  
✅ **DBK_006** - Terastallization ⭐ (Skill 100+)  
✅ **DBK_007** - Improved Item AI

### Andere Plugins

✅ Generation 9 Pack  
✅ Challenge Modes (Auto-Aktivierung)  
✅ Modular UI  
✅ Charms Compilation  
✅ Arcky's Region Map

**Keine bekannten Konflikte!**

---

## 📈 Performance

- **Move Scoring**: ~3-5ms pro Zug
- **Switch Analysis**: ~5-8ms pro Check
- **Dynamax/Tera**: ~2-4ms pro Bewertung
- **Gesamt**: <15ms pro Zug (nicht spürbar)

**Speicher**: ~100KB pro Kampf

---

## 🐛 Problembehandlung

### KI aktiviert sich nicht

```ruby
# Prüfe Einstellungen
AdvancedAI::ENABLED = true
MIN_SKILL_FOR_AUTO_ACTIVATION = 50  # Senken

# Manuell aktivieren
AdvancedAI.activate!
```

### Switch Intelligence funktioniert nicht

```ruby
# Prüfe Skill-Level
skill = 65  # Minimum für gute Switch-AI
pbTrainerBattle(:LEADER_Brock, "Rocko", nil, false, 0, true, skill)

# Debug aktivieren
DEBUG_MODE = true
# Schau in Console nach "[Switch]" Meldungen
```

### Dynamax/Tera funktioniert nicht

```ruby
# 1. Plugin installiert?
AdvancedAI.dbk_enabled?(:dynamax)       # → true?
AdvancedAI.dbk_enabled?(:terastallization)  # → true?

# 2. Skill-Level hoch genug?
skill = 95   # Für Dynamax
skill = 100  # Für Terastallization

# 3. Pokemon kann es nutzen?
battler.can_dynamax?  # → true?
battler.can_terastallize?  # → true?
```

---

## 📚 Entwickler-Referenz

### API-Methoden

```ruby
# System-Status
AdvancedAI.active?                        # → Boolean
AdvancedAI.qualifies_for_advanced_ai?(70) # → Boolean
AdvancedAI.get_ai_tier(100)               # → :master

# Feature-Checks
AdvancedAI.feature_enabled?(:dynamax, 95)      # → Boolean
AdvancedAI.dbk_enabled?(:terastallization)     # → Boolean

# Battle-Methoden
battle.uses_advanced_ai?(trainer_index)   # → Boolean

# Battler-Methoden
battler.ai_skill_level                    # → Integer (0-100+)
battler.ai_tier                           # → Symbol (:basic, :core, etc.)
```

### Eigene Systeme erweitern

```ruby
class Battle::AI
  # Custom Scoring Modifier
  def apply_custom_logic(score, move, user, target, skill)
    # Drachen-Bonus für Skill 100+
    if move.type == :DRAGON && skill >= 100
      score += 25
    end
    
    return score
  end
  
  # In [002] Core.rb einbinden:
  alias original_apply_advanced_modifiers apply_advanced_modifiers
  def apply_advanced_modifiers(score, move, user, target, skill)
    score = original_apply_advanced_modifiers(score, move, user, target, skill)
    score = apply_custom_logic(score, move, user, target, skill)
    return score
  end
end
```

---

## 📝 Was macht dieses System anders?

### 1. **Reborn-Inspired Move Memory** 🧠
- KI **trackt alle Spieler-Moves** permanent
- Nutzt Memory für Switch-Entscheidungen
- Erkennt Priority Moves → Protect-Timing
- Berechnet Max Damage → Überlebens-Kalkulation

### 2. **Intelligente Threat Assessment** ⚠️
- **10-Punkte-Skala** (0 = harmlos, 10 = tödlich)
- 8 Bewertungs-Faktoren (Stats, Typ, Moves, Ability, HP, Setup, Speed)
- Priorität-System für Doubles
- Switch bei threat > 7.0

### 3. **Role Detection System** 🎭
- **7 automatisch erkannte Rollen**
- Counter-Pick-Logik (Sweeper → Wall)
- Bestes Pokemon für Situation finden
- Rollen-basiertes Switching

### 4. **Doubles Coordination** 🤝
- Overkill-Prevention (kein Fokus auf schwache Ziele)
- Move Conflict Prevention (keine doppelten Screens)
- Spread Move Optimization (EQ mit Flying Partner)
- Protect + Setup Combos

### 5. **Field Effects Mastery** 🌦️
- Weather Awareness (+30 für passende Typen)
- Terrain Synergy (Grassy -20 für EQ)
- Trick Room Logic (bevorzugt langsame Pokemon)
- Ability-Weather-Synergien (Swift Swim + Rain)

### 6. **Echte Switch-In Logik** 🔄
- KI wechselt proaktiv bei schlechten Matchups
- Evaluiert 6+ Faktoren für Wechsel-Entscheidung
- Findet beste Switch-Option aus Team
- Berücksichtigt Entry Hazards
- **Rollen-basiertes Switching** (Counter-Picks)

### 7. **DBK-Integration** ⚡
- Nutzt Dynamax strategisch (nicht random)
- Terastallize für Survival oder Sweep
- Z-Moves zur richtigen Zeit
- Raid Battle Awareness

### 8. **Skill-basiert skalierbar** 📊
- Route-Trainer: Basic AI
- Arena-Leiter: Move Memory + Threat Assessment
- Top Vier: + Field Effects + Role Detection
- Champion: + Dynamax/Tera Mastery

### 9. **Performance-optimiert** ⚡
- Cached Berechnungen
- <20ms pro Zug
- Keine FPS-Drops
- Memory Cleanup nach Battle

---

## 👥 Credits

**Autor**: Marcel Weidenauer  
**Version**: 2.1.0  
**Datum**: Dezember 2024

**Inspiration**:
- Pokémon Essentials Team
- Radical Red AI
- Smogon Competitive Community

---

## 📜 Lizenz

Kostenlos für nicht-kommerzielle Pokémon Fan-Spiele.

**Rechte**:
- ✅ Nutzen in Fan-Games
- ✅ Modifizieren & Anpassen
- ✅ Teilen mit anderen
- ❌ Kommerzielle Nutzung (ohne Erlaubnis)

---

## 🔮 Implementierte Features (v3.0.0) - KOMPLETT!

### Core Systems (Skill 50+)
- [x] **[001] Settings** - Konfigurations-Management
- [x] **[002] Core** - Basis-Integration mit Essentials v21.1
- [x] **[003] Move_Scorer** - Intelligente Attacken-Bewertung

### Reborn-Inspired Systems ⭐
- [x] **[007] Move_Memory** - Trackt alle Gegner-Moves permanent
- [x] **[008] Threat_Assessment** - 10-Punkte-Skala Gefahrenbewertung
- [x] **[009] Doubles_Coordination** - Partner-Synergie & Overkill-Prevention
- [x] **[010] Field_Effects** - Wetter, Terrain, Trick Room Awareness
- [x] **[011] Role_Detection** - 7 Pokemon-Rollen erkennen
- [x] **[012] Switch_Intelligence** - 6 Faktoren + Rollen-basierte Logik

### Advanced Content (Skill 55-85+)
- [x] **[013] Custom_Content** - 267 Gen 1-9 Abilities analysiert
- [x] **[014] Move_Categories** - 900+ kategorisierte Moves
- [x] **[015] Item_Intelligence** - 693 Items analysiert
- [x] **[016] Prediction_System** - Switch & Move Prediction
- [x] **[017] Team_Preview** - Optimale Lead-Auswahl
- [x] **[019] Setup_Recognition** - 5 Bewertungs-Systeme
- [x] **[020] Endgame_Scenarios** - 1v1/2v2 Spezial-Logik
- [x] **[021] Battle_Personalities** - 4 Spielstile

### DBK Integration (Skill 95-100+)
- [x] **[022] Dynamax_Intelligence** - DBK_005 Integration
- [x] **[023] Terastallization_Intelligence** - DBK_006 Integration

---

**🎉 v3.0.0 = VOLLSTÄNDIG! Alle 18 Module implementiert!**

**Stats:**
- 18 Module
- ~15.000 Codezeilen
- 267 Abilities
- 900+ Moves kategorisiert
- 693 Items analysiert
- 7 Pokemon-Rollen
- 4 Battle-Personalities
- 5 Setup-Counter-Systeme

---

**Advanced AI System v3.0.0 - Master-Tier Intelligence with Full Gen 9 Support**

Made with ❤️ for Hardmode Players | Inspired by Pokémon Reborn

**🌟 Key Features:**
- Move Memory System (trackt alle Gegner-Züge)
- Threat Assessment (10-Punkte-Skala mit 8 Faktoren)
- Role Detection (7 Rollen mit Counter-Picks)
- Doubles Coordination (4 Prevention-Systeme)
- Field Effects Mastery (Weather/Terrain/Rooms)
- 267 Gen 1-9 Abilities analysiert
- 900+ Move Categories
- 693 Items Intelligence
- Setup Recognition (5 Systeme)
- Endgame Logic (1v1/2v2)
- Battle Personalities (4 Spielstile)
- Prediction System (Switch/Move)
- Team Preview Intelligence
- DBK Integration (Dynamax/Tera)
