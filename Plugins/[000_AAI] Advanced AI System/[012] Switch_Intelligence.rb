#===============================================================================
# Advanced AI System - Switch Intelligence
# Intelligente Wechsel-Entscheidungen mit Typ-Matchup und Momentum-Kontrolle
#===============================================================================

class Battle::AI
  #=============================================================================
  # SWITCH ANALYZER - Evaluiert Wechsel-Gelegenheiten
  #=============================================================================
  
  # Analysiert ob AI wechseln sollte (erweiterte Version)
  def should_switch_advanced?(user, skill = 100)
    return false unless user && !user.fainted?
    return false if user.trappedInBattle?
    return false unless AdvancedAI.feature_enabled?(:core, skill)
    
    # Initialize switch analysis cache
    @switch_analyzer[user.index] ||= {}
    cache = @switch_analyzer[user.index]
    
    # Berechne Switch Score
    switch_score = calculate_switch_score(user, skill)
    
    # Cache result
    cache[:last_score] = switch_score
    cache[:last_turn] = @battle.turnCount
    
    AdvancedAI.log("Switch score for #{user.pbThis}: #{switch_score}", "Switch")
    
    # Schwellenwerte basierend auf Skill
    threshold = case AdvancedAI.get_ai_tier(skill)
                when :master then 35
                when :expert then 40
                when :advanced then 45
                else 50
                end
    
    return switch_score >= threshold
  end
  
  public # Force this method to be public for Core.rb integration
  
  # Findet das beste Switch-Pokemon (public für Core.rb Integration)
  def find_best_switch_advanced(user, skill)
    echoln "  ┌─────────────────────────────────────┐"
    echoln "  │ FINDING BEST REPLACEMENT            │"
    echoln "  └─────────────────────────────────────┘"
    
    party = @battle.pbParty(user.index)
    available_switches = []
    
    echoln "  → Analyzing party (#{party.length} Pokemon):"
    
    party.each_with_index do |pkmn, i|
      if !pkmn
        echoln "    [#{i}] (nil slot)"
        next
      end
      
      status = []
      status << "FAINTED" if pkmn.fainted?
      status << "EGG" if pkmn.egg?
      status << "IN BATTLE" if @battle.pbFindBattler(i, user.index)
      status << "CAN'T SWITCH" unless @battle.pbCanSwitchIn?(user.index, i)
      
      if status.empty?
        # Valid for switching
        matchup_score = evaluate_switch_matchup_detailed(pkmn, user)
        available_switches.push([pkmn, matchup_score, i])
        echoln "    [#{i}] #{pkmn.name}: Matchup = #{matchup_score} ✅"
      else
        echoln "    [#{i}] #{pkmn.name}: SKIPPED (#{status.join(', ')})"
      end
    end
    
    echoln ""
    
    if available_switches.empty?
      echoln "  >>> No valid switches available!"
      return nil
    end
    
    # Sort by matchup score (highest first)
    available_switches.sort_by! { |_, score, _| -score }
    best_pkmn, best_score, best_idx = available_switches.first
    
    echoln "  ─────────────────────────────────────"
    echoln "  ✅ BEST OPTION: #{best_pkmn.name}"
    echoln "  Matchup Score: #{best_score}"
    
    # Return a wrapper object with pokemon and battler info
    return OpenStruct.new(pokemon: best_pkmn, index: best_idx, name: best_pkmn.name)
  end

  private # All methods below are private helper methods
  
  # Berechnet Switch Score (0-100+)
  def calculate_switch_score(user, skill)
    echoln "  ┌─────────────────────────────────────┐"
    echoln "  │ SWITCH SCORE CALCULATION            │"
    echoln "  └─────────────────────────────────────┘"
    score = 0
    
    # 1. TYP-MATCHUP ANALYSE (0-40 Punkte)
    type_score = evaluate_type_disadvantage(user, skill)
    score += type_score
    echoln("  [1/8] Type Disadvantage: +#{type_score}") if type_score > 0
    
    # 2. HP & STATUS ANALYSE (0-30 Punkte)
    survival_score = evaluate_survival_concerns(user, skill)
    score += survival_score
    echoln("  [2/8] Survival Concerns: +#{survival_score}") if survival_score > 0
    
    # 3. STAT STAGE ANALYSE (0-25 Punkte)
    stat_score = evaluate_stat_stages(user, skill)
    score += stat_score
    echoln("  [3/8] Stat Stage Loss: +#{stat_score}") if stat_score > 0
    
    # 4. BESSERE OPTION VERFÜGBAR (0-35 Punkte)
    better_score = evaluate_better_options(user, skill)
    score += better_score
    echoln("  [4/8] Better Options: +#{better_score}") if better_score > 0
    
    # 5. MOMENTUM KONTROLLE (0-20 Punkte)
    if AdvancedAI.get_setting(:momentum_control) > 0
      momentum_score = evaluate_momentum(user, skill)
      score += momentum_score
      echoln("  [5/8] Momentum Control: +#{momentum_score}") if momentum_score > 0
    end
    
    # 6. VORHERSAGE-BONUS (0-15 Punkte)
    if skill >= 85
      prediction_score = evaluate_prediction_advantage(user, skill)
      score += prediction_score
      echoln("  [6/8] Prediction: +#{prediction_score}") if prediction_score > 0
    end
    
    # 7. MALUS: Momentum verlieren (-20 Punkte)
    if user_has_advantage?(user)
      score -= 20
      echoln("  [7/8] Has Advantage (malus): -20")
    end
    
    # 8. MALUS: Setup verschwenden (-30 Punkte)
    if user.stages.values.any? { |stage| stage > 0 }
      total_boosts = user.stages.values.sum
      malus = [total_boosts * 10, 30].min
      score -= malus
      echoln("  [8/8] Wasting Setup +#{total_boosts} (malus): -#{malus}")
    end
    
    echoln "  ─────────────────────────────────────"
    echoln "  TOTAL SWITCH SCORE: #{score}"
    
    # Threshold anzeigen
    threshold = case AdvancedAI.get_ai_tier(skill)
                when :master then 35
                when :expert then 40
                when :advanced then 45
                else 50
                end
    echoln "  Threshold (#{AdvancedAI.get_ai_tier(skill)}): #{threshold}"
    echoln "  Decision: #{score >= threshold ? '✅ SWITCH' : '❌ STAY'}"
    
    return score
  end
  
  #=============================================================================
  # EVALUIERUNGS-METHODEN
  #=============================================================================
  
  # 1. Typ-Nachteil Evaluierung
  def evaluate_type_disadvantage(user, skill)
    score = 0
    
    @battle.allOtherSideBattlers(user.index).each do |target|
      next unless target && !target.fainted?
      
      echoln("    → Analyzing vs #{target.name} [#{target.pbTypes(true).join('/')}]")
      
      # Offensive Bedrohung (Gegner kann User sehr effektiv treffen)
      target.moves.each do |move|
        next unless move
        type_mod = Effectiveness.calculate(move.type, *user.pbTypes(true))
        if Effectiveness.super_effective?(type_mod)
          score += 20  # Sehr effektive Attacke!
          echoln("      • #{move.name} [#{move.type}] → SUPER EFFECTIVE! (+20)")
        end
      end
      
      # Defensive Schwäche (User kann Gegner nicht effektiv treffen)
      user_offensive = user.moves.map do |move|
        next 0 unless move
        type_mod = Effectiveness.calculate(move.type, *target.pbTypes(true))
        Effectiveness.not_very_effective?(type_mod) ? 1.0 : 0.0
      end.count { |x| x > 0 }
      
      score += 10 if user_offensive >= 3  # Meiste Attacken nicht sehr effektiv
      
      # STAB-Nachteil
      target.moves.each do |move|
        next unless move
        if target.pbHasType?(move.type)  # STAB
          type_mod = Effectiveness.calculate(move.type, *user.pbTypes(true))
          score += 15 if Effectiveness.super_effective?(type_mod)
        end
      end
    end
    
    return [score, 40].min  # Cap bei 40
  end
  
  # 2. Überlebens-Bedenken
  def evaluate_survival_concerns(user, skill)
    score = 0
    hp_percent = user.hp.to_f / user.totalhp
    
    # Niedrige HP
    if hp_percent < 0.25
      score += 30
    elsif hp_percent < 0.40
      score += 20
    elsif hp_percent < 0.55
      score += 10
    end
    
    # Keine Heilungs-Optionen
    has_recovery = user.moves.any? do |m|
      next false unless m
      move_data = GameData::Move.try_get(m.id)
      next false unless move_data
      move_data.function_code.start_with?("HealUser") || 
        ["Roost", "Synthesis", "MorningSun", "Moonlight", "Recover", "Softboiled", "Wish", "Rest"].include?(move_data.real_name)
    end
    score += 10 if !has_recovery && hp_percent < 0.5
    
    # Schädlicher Status
    if user.status != :NONE
      case user.status
      when :POISON, :BURN
        score += 15
      when :TOXIC
        score += 20
      when :SLEEP, :FROZEN
        score += 10
      when :PARALYSIS
        score += 5
      end
    end
    
    # OHKO-Gefahr
    @battle.allOtherSideBattlers(user.index).each do |target|
      next unless target && !target.fainted?
      
      # Schneller Gegner mit hoher Angriffskraft
      if target.pbSpeed > user.pbSpeed
        target.moves.each do |move|
          next unless move && move.damagingMove?
          type_mod = pbCalcTypeMod(move.type, user, target)
          
          # Grobe Schadens-Schätzung
          if Effectiveness.super_effective?(type_mod)
            estimated_damage = (target.attack * move.base_damage * 2.0) / [user.defense, 1].max
            score += 15 if estimated_damage >= user.hp
          end
        end
      end
    end
    
    return [score, 30].min
  end
  
  # 3. Stat Stage Analyse
  def evaluate_stat_stages(user, skill)
    score = 0
    
    # Negative Stat Stages
    negative_stages = user.stages.values.count { |stage| stage < 0 }
    score += negative_stages * 8
    
    # Kritische Senkungen
    score += 10 if user.stages[:ATTACK] <= -2 && user.attack > user.spatk
    score += 10 if user.stages[:SPECIAL_ATTACK] <= -2 && user.spatk > user.attack
    score += 12 if user.stages[:SPEED] <= -2
    
    # Gegner mit vielen Boosts
    @battle.allOtherSideBattlers(user.index).each do |target|
      next unless target && !target.fainted?
      
      positive_stages = target.stages.values.count { |stage| stage > 0 }
      score += 5 if positive_stages >= 2
      score += 10 if positive_stages >= 4
    end
    
    return [score, 25].min
  end
  
  # 4. Bessere Optionen verfügbar
  def evaluate_better_options(user, skill)
    score = 0
    
    party = @battle.pbParty(user.index)
    available_switches = party.select.with_index do |pkmn, i|
      pkmn && !pkmn.fainted? && !pkmn.egg? && !@battle.pbFindBattler(i, user.index)
    end
    
    return 0 if available_switches.empty?
    
    # Finde beste Alternative
    best_matchup_score = 0
    best_switch = nil
    
    available_switches.each do |switch_mon|
      matchup = evaluate_switch_matchup(switch_mon, user)
      if matchup > best_matchup_score
        best_matchup_score = matchup
        best_switch = switch_mon
      end
    end
    
    # Bonus wenn deutlich bessere Option existiert
    if best_matchup_score > 30
      score += 35
      echoln("[AAI Switch] Beste Option: #{best_switch.name} (Matchup +#{best_matchup_score})")
    elsif best_matchup_score > 15
      score += 25
      echoln("[AAI Switch] Gute Option: #{best_switch.name} (Matchup +#{best_matchup_score})")
    elsif best_matchup_score > 5
      score += 15
    end
    
    return score
  end
  
  # 5. Momentum Kontrolle
  def evaluate_momentum(user, skill)
    score = 0
    
    # Momentum-Shift forcieren wenn hinten
    alive_user = @battle.pbParty(user.index).count { |p| p && !p.fainted? }
    alive_enemy = @battle.allOtherSideBattlers(user.index).count { |b| 
      b && !b.fainted? && @battle.pbParty(b.index).count { |p| p && !p.fainted? } > 0
    }
    
    if alive_user < alive_enemy
      score += 10  # Momentum-Shift versuchen
    end
    
    # Predict-Switch wenn Gegner Setup machen will
    @battle.allOtherSideBattlers(user.index).each do |target|
      next unless target && !target.fainted?
      
      # Gegner hat Setup-Moves (check function codes)
      has_setup = target.moves.any? do |m|
        next false unless m && m.is_a?(Battle::Move) && m.statusMove?
        move_data = GameData::Move.try_get(m.id)
        next false unless move_data
        # Setup moves have function codes like RaiseUserAttack2, RaiseMultipleStats, etc.
        move_data.function_code.to_s.include?("RaiseUser") || move_data.function_code.to_s.include?("RaiseMulti")
      end
      score += 15 if has_setup && user_has_type_disadvantage?(user, target)
    end
    
    return [score, 20].min
  end
  
  # 6. Vorhersage-Vorteil (Skill 85+)
  def evaluate_prediction_advantage(user, skill)
    return 0 unless skill >= 85
    score = 0
    
    # Wenn Gegner wahrscheinlich wechselt, stay in
    # Wenn Gegner wahrscheinlich setuppt, switch out
    
    @battle.allOtherSideBattlers(user.index).each do |target|
      next unless target && !target.fainted?
      
      # Analyse letzter Moves
      if @move_memory[target.index]
        last_moves = @move_memory[target.index][:moves] || []
        
        # Pattern: Wiederholte Setup-Moves
        setup_count = last_moves.count do |m|
          next false unless m
          move_data = GameData::Move.try_get(m)
          next false unless move_data
          move_data.function_code.to_s.include?("RaiseUser") || move_data.function_code.to_s.include?("RaiseMulti")
        end
        score += 10 if setup_count >= 2
        
        # Pattern: Predict Gegner-Switch (wenn wenig HP)
        if target.hp < target.totalhp * 0.35
          score -= 15  # Stay in, Gegner wechselt vermutlich
        end
      end
    end
    
    return [score, 15].min
  end
  
  #=============================================================================
  # BESTE SWITCH-OPTION FINDEN
  #=============================================================================
  
  def find_best_switch_advanced(user, skill)
    party = @battle.pbParty(user.index)
    best_index = -1
    best_score = -999
    
    party.each_with_index do |pkmn, i|
      next if !pkmn || pkmn.fainted? || pkmn.egg?
      next if @battle.pbFindBattler(i, user.index)
      
      score = evaluate_switch_candidate_detailed(pkmn, user, skill)
      
      if score > best_score
        best_score = score
        best_index = i
      end
    end
    
    AdvancedAI.log("Best switch: Index #{best_index} with score #{best_score}", "Switch")
    
    return best_index if best_score > 0
    return -1
  end
  
  # Detaillierte Switch-Kandidaten-Bewertung
  def evaluate_switch_candidate_detailed(pkmn, current_user, skill)
    score = 50  # Base score
    
    # 1. TYP-MATCHUP (0-50 Punkte)
    score += evaluate_switch_matchup(pkmn, current_user)
    
    # 2. HP & STATUS (0-20 Punkte)
    hp_percent = pkmn.hp.to_f / pkmn.totalhp
    score += (hp_percent * 20).to_i
    score -= 20 if pkmn.status != :NONE
    
    # 3. GESCHWINDIGKEIT (0-15 Punkte)
    @battle.allOtherSideBattlers(current_user.index).each do |target|
      next unless target && !target.fainted?
      score += 15 if pkmn.speed > target.pbSpeed
    end
    
    # 4. ROLLEN-ANALYSE (0-25 Punkte)
    role_bonus = evaluate_switch_role(pkmn, current_user, skill)
    score += role_bonus
    
    # 5. ENTRY HAZARDS RESISTANCE (0-15 Punkte)
    if @battle.pbOwnedByPlayer?(current_user.index)
      opponent_side = @battle.sides[1]
    else
      opponent_side = @battle.sides[0]
    end
    
    # Stealth Rock Resistance
    if opponent_side.effects[PBEffects::StealthRock]
      effectiveness = Effectiveness.calculate(:ROCK, pkmn.types[0], pkmn.types[1])
      if Effectiveness.ineffective?(effectiveness)
        score += 15
      elsif Effectiveness.not_very_effective?(effectiveness)
        score += 10
      elsif Effectiveness.super_effective?(effectiveness)
        score -= 15
      end
    end
    
    # Spikes
    if opponent_side.effects[PBEffects::Spikes] > 0
      score += 10 if pkmn.hasType?(:FLYING) || pkmn.hasAbility?(:LEVITATE)
    end
    
    # 6. ABILITY SYNERGY (0-20 Punkte)
    ability = pkmn.ability
    if ability
      # Intimidate beim Switch-In
      score += 20 if ability == :INTIMIDATE
      
      # Weather/Terrain abilities
      score += 15 if [:DRIZZLE, :DROUGHT, :SANDSTREAM, :SNOWWARNING].include?(ability)
      
      # Defensive abilities
      score += 10 if [:REGENERATOR, :NATURALCURE, :IMMUNITY].include?(ability)
    end
    
    return score
  end
  
  # Matchup-Bewertung für Switch
  def evaluate_switch_matchup(switch_mon, current_user)
    score = 0
    
    # Validate types
    return 0 unless switch_mon && switch_mon.types
    
    @battle.allOtherSideBattlers(current_user.index).each do |target|
      next unless target && !target.fainted?
      
      # Offensive Typ-Vorteil
      switch_mon_types = [switch_mon.types[0], switch_mon.types[1]].compact.uniq
      return 0 if switch_mon_types.empty?
      
      target_types = [target.types[0], target.types[1]].compact
      next if target_types.empty?
      
      switch_mon_types.each do |type|
        next unless type  # Skip nil
        effectiveness = Effectiveness.calculate(type, *target_types)
        if Effectiveness.super_effective?(effectiveness)
          score += 20
        elsif Effectiveness.not_very_effective?(effectiveness)
          score -= 10
        end
      end
      
      # Defensive Typ-Vorteil
      target.moves.each do |move|
        next unless move && move.damagingMove?
        next unless move.type  # Skip nil types
        switch_types = [switch_mon.types[0], switch_mon.types[1]].compact
        next if switch_types.empty?
        effectiveness = Effectiveness.calculate(move.type, *switch_types)
        if Effectiveness.ineffective?(effectiveness)
          score += 40  # IMMUNITÄT ist extrem wertvoll!
        elsif Effectiveness.not_very_effective?(effectiveness)
          score += 15  # Resistenz ist gut
        elsif Effectiveness.super_effective?(effectiveness)
          score -= 25  # Schwäche ist schlecht
        end
      end
    end
    
    return score
  end
  
  # Rollen-basierte Switch-Bewertung
  def evaluate_switch_role(pkmn, current_user, skill)
    return 0 unless skill >= 55
    score = 0
    
    # Bestimme Rolle des aktuellen Pokemon
    current_role = determine_pokemon_role(current_user)
    switch_role = determine_pokemon_role_from_stats(pkmn)
    
    # Komplementäre Rollen bevorzugen
    case current_role
    when :sweeper
      score += 15 if [:wall, :tank].include?(switch_role)
    when :wall
      score += 15 if [:sweeper, :wallbreaker].include?(switch_role)
    when :support
      score += 20 if [:sweeper, :wallbreaker].include?(switch_role)
    end
    
    return score
  end
  
  # Findet das beste Switch-Pokemon (public für Core.rb Integration)
  def find_best_switch_advanced(user, skill)
    echoln "  ┌─────────────────────────────────────┐"
    echoln "  │ FINDING BEST REPLACEMENT            │"
    echoln "  └─────────────────────────────────────┘"
    
    party = @battle.pbParty(user.index)
    available_switches = []
    
    party.each_with_index do |pkmn, i|
      next unless pkmn && !pkmn.fainted? && !pkmn.egg?
      next if @battle.pbFindBattler(i, user.index) # Already in battle
      next unless @battle.pbCanSwitchIn?(user.index, i)
      
      matchup_score = evaluate_switch_matchup_detailed(pkmn, user)
      available_switches.push([pkmn, matchup_score, i])
      
      echoln "  • #{pkmn.name}: Matchup = #{matchup_score}"
    end
    
    if available_switches.empty?
      echoln "  >>> No valid switches available!"
      return nil
    end
    
    # Sort by matchup score (highest first)
    available_switches.sort_by! { |_, score, _| -score }
    best_pkmn, best_score, best_idx = available_switches.first
    
    echoln "  ─────────────────────────────────────"
    echoln "  ✅ BEST OPTION: #{best_pkmn.name}"
    echoln "  Matchup Score: #{best_score}"
    
    # Return party index directly (Core.rb expects integer)
    return best_idx
  end
  
  private
  
  # Detaillierte Matchup-Bewertung für Switch-Auswahl
  def evaluate_switch_matchup_detailed(switch_pkmn, current_user)
    score = 0
    
    # Validate switch_pkmn has types
    return 0 unless switch_pkmn && switch_pkmn.types
    switch_types = [switch_pkmn.types[0], switch_pkmn.types[1]].compact
    return 0 if switch_types.empty? || switch_types.any?(&:nil?)
    
    # Analyse gegen alle Gegner
    @battle.allOtherSideBattlers(current_user.index).each do |target|
      next unless target && !target.fainted?
      
      target_types = target.pbTypes(true).compact
      next if target_types.empty? || target_types.any?(&:nil?)
      
      # Defensive Matchup (eingehende Moves)
      target.moves.each do |move|
        next unless move && move.damagingMove?
        next unless move.type  # Skip if move has no type
        
        move_type = move.pbCalcType(target)  # target is already a Battle::Battler
        next unless move_type  # Skip if calculated type is nil
        
        # Additional safety: ensure all switch types are valid
        next if switch_types.any? { |t| t.nil? }
        
        eff = Effectiveness.calculate(move_type, *switch_types)
        
        if Effectiveness.ineffective?(eff)
          score += 40
        elsif Effectiveness.not_very_effective?(eff)
          score += 15
        elsif Effectiveness.super_effective?(eff)
          score -= 25
        end
      end
      
      # Offensive Matchup (ausgehende Moves)
      switch_pkmn.moves.each do |move|
        next unless move && move.id
        move_data = GameData::Move.try_get(move.id)
        next unless move_data
        next if move_data.category == 2  # Skip status moves (0=Physical, 1=Special, 2=Status)
        next unless move_data.type  # Skip if move has no type
        
        # Additional safety: ensure all target types are valid
        next if target_types.any? { |t| t.nil? }
        
        eff = Effectiveness.calculate(move_data.type, *target_types)
        
        if Effectiveness.super_effective?(eff)
          score += 20
        elsif Effectiveness.ineffective?(eff)
          score -= 10
        end
      end
    end
    
    return score
  end

  #=============================================================================
  # HELPER METHODS
  #=============================================================================
  
  def user_has_advantage?(user)
    @battle.allOtherSideBattlers(user.index).all? do |target|
      next true unless target && !target.fainted?
      
      # Type advantage
      user.moves.any? do |move|
        next false unless move && move.damagingMove?
        type_mod = Effectiveness.calculate(move.type, *target.pbTypes(true))
        Effectiveness.super_effective?(type_mod)
      end
    end
  end
  
  def user_has_type_disadvantage?(user, target)
    target.moves.any? do |move|
      next false unless move && move.damagingMove?
      type_mod = Effectiveness.calculate(move.type, *user.pbTypes(true))
      Effectiveness.super_effective?(type_mod)
    end
  end
  
  def determine_pokemon_role(battler)
    # Simplified role detection (wird in [011] erweitert)
    if battler.attack > battler.spatk && battler.speed > 100
      return :sweeper
    elsif battler.defense > 100 || battler.spdef > 100
      return :wall
    else
      return :balanced
    end
  end
  
  def determine_pokemon_role_from_stats(pkmn)
    # Simplified role detection
    if pkmn.attack > pkmn.spatk && pkmn.speed > 100
      return :sweeper
    elsif pkmn.defense > 100 || pkmn.spdef > 100
      return :wall
    else
      return :balanced
    end
  end
end

AdvancedAI.log("Switch Intelligence loaded", "Switch")
