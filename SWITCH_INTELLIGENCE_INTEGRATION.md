# Advanced AI Switch Intelligence - Integration Complete

## Problem
The Advanced AI System's switch intelligence ([012] Switch_Intelligence.rb) was fully implemented with extensive scoring logic and debug logging, but it was **never called** during battles. The AI would not switch out Skarmoray (Steel/Flying) when facing Raging Bolt (Electric/Dragon), even though Gliscor (Ground/Flying) or Excadrill (Ground/Steel) with immunity were available.

## Root Cause
The switch intelligence module was **orphaned code** - it had all the logic but no integration point:
- `should_switch_advanced?()` was defined but had **zero callers**
- `find_best_switch_advanced()` was never invoked
- All the debug logging (`echoln` statements) never executed
- The AI used vanilla Essentials switch logic exclusively

## Solution
Integrated Advanced AI switch intelligence into Pokemon Essentials' handler system in **[002] Core.rb**:

### 1. Switch Decision Handler
```ruby
Battle::AI::Handlers::ShouldSwitch.add(:advanced_ai_switch_intelligence,
  proc { |battler, reserves, ai, battle|
    skill = ai.trainer&.skill || 100
    next false unless AdvancedAI.qualifies_for_advanced_ai?(skill)
    next false unless AdvancedAI.feature_enabled?(:switch_intelligence, skill)
    
    echoln "[AAI Core] Checking advanced switch logic for #{battler.name} (skill: #{skill})"
    
    if ai.should_switch_advanced?(battler, skill)
      echoln "[AAI Core] Advanced AI recommends switching #{battler.name}"
      next true
    end
    
    next false
  }
)
```

This handler runs **before** vanilla switch handlers like `perish_song`, `significant_eor_damage`, `high_damage_from_foe`, etc.

### 2. Replacement Selection Override
```ruby
class Battle::AI
  alias aai_choose_best_replacement_pokemon choose_best_replacement_pokemon
  def choose_best_replacement_pokemon(idxBattler, terrible_moves = false)
    skill = @trainer&.skill || 100
    
    if AdvancedAI.qualifies_for_advanced_ai?(skill) && 
       AdvancedAI.feature_enabled?(:switch_intelligence, skill)
      echoln "[AAI Core] Using advanced replacement selection for #{@user.name}"
      
      best_switch = find_best_switch_advanced(@user, skill)
      if best_switch
        echoln "[AAI Core] Advanced AI chose: #{best_switch.name}"
        # Find and return party index
        ...
      end
    end
    
    # Fall back to vanilla logic
    return aai_choose_best_replacement_pokemon(idxBattler, terrible_moves)
  end
end
```

This override uses our advanced switch finder instead of vanilla `rate_replacement_pokemon()`.

## How It Works

### Battle Flow
1. **pbDefaultChooseEnemyCommand** (DBK Command Menu Refactor)
   - Calls `pbChooseToSwitchOut()` first
   
2. **pbChooseToSwitchOut** (Essentials AI_Switch.rb)
   - Checks `Battle::AI::Handlers.should_switch?()`
   - Loops through all registered handlers
   - **Our handler runs FIRST** (`:advanced_ai_switch_intelligence`)
   
3. **should_switch_advanced?** ([012] Switch_Intelligence.rb)
   - Calculates total switch score from 8 components:
     - Type Disadvantage: +20 per super effective move
     - Survival: +30 if low HP
     - Stat Stages: +25 if minimal setup lost
     - **Better Options: +35 if reserve has type advantage**
     - Momentum Control: +20 if opponent has setup
     - Prediction: +15 if opponent likely to switch
     - Advantage: -20 if currently winning matchup
     - Setup Waste: -30 if high stat boosts
   
4. **Switch Score Thresholds**
   - Master (skill 90-100): 35 points needed
   - Expert (skill 70-89): 40 points needed
   - Advanced (skill 50-69): 45 points needed
   - Default: 50 points needed

5. **find_best_switch_advanced?** ([012] Switch_Intelligence.rb)
   - Evaluates each reserve's type matchup
   - **Immunity (0x): +40 points**
   - Resistance (0.5x): +15 points
   - Weakness (2x): -25 points
   - Returns best candidate with highest matchup score

## Debug Output
When switch intelligence activates, you'll see:
```
[AAI Core] Checking advanced switch logic for Skarmoray (skill: 100)
[AAI Switch] === SWITCH ANALYSIS: Skarmoray ===
[AAI Switch] Skarmoray: Type Disadvantage = +40
[AAI Switch] Skarmoray: Survival = +30
[AAI Switch] Skarmoray: Stat Stages = +25
[AAI Switch] Beste Option: Gliscor (Matchup +55)
[AAI Switch] Skarmoray: Better Options = +35
[AAI Switch] Skarmoray: Momentum Control = +20
[AAI Switch] TOTAL SWITCH SCORE = 150
[AAI Switch] Threshold = 35 → SHOULD SWITCH
[AAI Core] Advanced AI recommends switching Skarmoray
[AAI Core] Using advanced replacement selection for Skarmoray
[AAI Switch] Evaluating switch options...
[AAI Switch] Gliscor matchup vs opponent moves:
[AAI Switch]   Thunderbolt (ELECTRIC) → Immunity! +40
[AAI Switch]   Dragon Pulse (DRAGON) → Resists 0.5x +15
[AAI Switch] Gliscor: Total matchup = +55
[AAI Core] Advanced AI chose: Gliscor
```

## Skarmoray vs Raging Bolt Example

**Scenario**: AI has Skarmoray (Steel/Flying) facing Raging Bolt (Electric/Dragon)

**Type Analysis**:
- Electric moves: 2x effective vs Skarmoray (Flying weakness)
- Electric moves: 0x vs Gliscor (Ground immunity)
- Electric moves: 0x vs Excadrill (Ground immunity)

**Switch Score Calculation**:
- Type Disadvantage: +40 (Electric is super effective)
- Better Options: +35 (Gliscor/Excadrill have immunity)
- Immunity Bonus: +40 (0x effectiveness valued highly)
- **Total: ~115 points (well above 35 threshold)**

**Result**: AI switches to Gliscor (or Excadrill), gaining immunity to Electric attacks.

## Files Modified
- **[002] Core.rb**: Added switch intelligence handler registration and replacement selection override
- **[012] Switch_Intelligence.rb**: Already complete, now integrated (no changes needed)

## Testing
1. Start a battle with high-skill trainer (skill 70+)
2. Create type disadvantage situation (e.g., Steel/Flying vs Electric)
3. Ensure AI has immune Pokemon in reserves (e.g., Ground-type)
4. Watch console output for `[AAI Switch]` messages
5. Verify AI switches to better matchup

## Benefits
- **Immunity Recognition**: +40 bonus ensures Ground-types switch in vs Electric
- **Threat Assessment**: 20 points per super effective move detected
- **Smart Thresholds**: Master trainers switch easier (35) than beginners (50)
- **Comprehensive Analysis**: 8 scoring components vs vanilla's 4
- **Full Transparency**: Debug logging shows WHY AI makes decisions
