#===============================================================================
# Advanced AI System - Move Scorer
# Intelligente Attacken-Bewertung mit 20+ Faktoren
#===============================================================================

class Battle::AI
  # Erweiterte Move-Scoring-Logik
  def score_move_advanced(move, user, target, skill)
    return 0 unless move && user && target
    
    base_score = 100  # Neutraler Start
    
    # === SCHADENS-ANALYSE ===
    if move.damagingMove?
      base_score += score_damage_potential(move, user, target, skill)
      base_score += score_type_effectiveness(move, user, target)
      base_score += score_stab_bonus(move, user)
      base_score += score_crit_potential(move, user, target)
    end
    
    # === STATUS-ANALYSE ===
    if move.statusMove?
      base_score += score_status_utility(move, user, target, skill)
    end
    
    # === SETUP-ANALYSE ===
    if move.stat_up.any?
      base_score += score_setup_value(move, user, target, skill)
    end
    
    # === SITUATIVE FAKTOREN ===
    base_score += score_priority(move, user, target)
    base_score += score_accuracy(move, skill)
    base_score += score_recoil_risk(move, user)
    base_score += score_secondary_effects(move, user, target)
    
    return base_score
  end
  
  private
  
  # Schadens-Potenzial
  def score_damage_potential(move, user, target, skill)
    score = 0
    
    # Base Power Bonus
    bp = move.base_damage
    score += (bp / 10).to_i if bp > 0
    
    # KO-Potential
    if skill >= 60
      rough_damage = calculate_rough_damage(move, user, target)
      if rough_damage >= target.hp
        score += 100  # Garantierter KO
      elsif rough_damage >= target.hp * 0.7
        score += 50   # Wahrscheinlicher KO
      elsif rough_damage >= target.hp * 0.4
        score += 25
      end
    end
    
    # Multi-Target Bonus
    score += 30 if move.pbTarget(user).num_targets > 1 && @battle.pbSideSize(0) > 1
    
    return score
  end
  
  # Typ-Effektivität
  def score_type_effectiveness(move, user, target)
    type_mod = pbCalcTypeMod(move.type, target, user)
    
    if Effectiveness.super_effective?(type_mod)
      return 40
    elsif Effectiveness.not_very_effective?(type_mod)
      return -30
    elsif Effectiveness.ineffective?(type_mod)
      return -200
    end
    
    return 0
  end
  
  # STAB Bonus
  def score_stab_bonus(move, user)
    return 20 if user.pbHasType?(move.type)
    return 0
  end
  
  # Kritische Treffer Potenzial
  def score_crit_potential(move, user, target)
    score = 0
    
    # Hohe Crit-Rate Moves
    if move.function_code == "HighCriticalHitRate"
      score += 15
    end
    
    # Crit-Stage erhöht
    if user.effects[PBEffects::FocusEnergy] > 0
      score += 20
    end
    
    # Ignoriert Stat-Änderungen
    if target.stages.values.any? { |stage| stage > 0 }
      score += 10
    end
    
    return score
  end
  
  # Status-Move Nützlichkeit
  def score_status_utility(move, user, target, skill)
    score = 0
    
    case move.function_code
    # Hazards
    when "AddSpikesToFoeSide"
      score += 60 if @battle.pbOwnedByPlayer?(target.index) ? 
                     @battle.sides[1].effects[PBEffects::Spikes] < 3 :
                     @battle.sides[0].effects[PBEffects::Spikes] < 3
    when "AddStealthRocksToFoeSide"
      side = @battle.pbOwnedByPlayer?(target.index) ? @battle.sides[1] : @battle.sides[0]
      score += 70 unless side.effects[PBEffects::StealthRock]
    when "AddToxicSpikesToFoeSide"
      side = @battle.pbOwnedByPlayer?(target.index) ? @battle.sides[1] : @battle.sides[0]
      score += 50 if side.effects[PBEffects::ToxicSpikes] < 2
      
    # Screens
    when "StartReflectScreen", "StartLightScreenScreen"
      score += 50
    when "StartAuroraVeilScreen"
      score += 60 if @battle.pbWeather == :Hail
      
    # Recovery
    when "HealUserHalfOfTotalHP", "HealUserDependingOnWeather"
      hp_percent = user.hp.to_f / user.totalhp
      score += 80 if hp_percent < 0.3
      score += 50 if hp_percent < 0.5
      score += 20 if hp_percent < 0.7
      
    # Status Infliction
    when "ParalyzeTarget"
      score += 40 if target.pbSpeed > user.pbSpeed && target.status == :NONE
    when "BurnTarget"
      score += 50 if target.attack > target.spatk && target.status == :NONE
    when "PoisonTarget", "BadPoisonTarget"
      score += 45 if target.status == :NONE && target.hp > target.totalhp * 0.7
      
    # Stat Drops
    when "LowerTargetAttack1", "LowerTargetAttack2"
      score += 30 if target.attack > target.spatk
    when "LowerTargetSpeed1", "LowerTargetSpeed2"
      score += 35 if target.pbSpeed > user.pbSpeed
    when "LowerTargetDefense1", "LowerTargetDefense2"
      score += 25 if user.attack > user.spatk
    end
    
    return score
  end
  
  # Setup-Wert
  def score_setup_value(move, user, target, skill)
    return 0 unless skill >= 55
    score = 0
    
    # Sichere Setup-Situation?
    safe_to_setup = is_safe_to_setup?(user, target)
    
    if safe_to_setup
      # Boost-Stärke
      total_boosts = move.stat_up.values.sum
      score += total_boosts * 20
      
      # Sweep-Potenzial
      if user.hp > user.totalhp * 0.7
        score += 30
      end
    else
      score -= 40  # Gefährlich zu setuppen
    end
    
    return score
  end
  
  # Priorität
  def score_priority(move, user, target)
    return 0 if move.priority <= 0
    
    score = move.priority * 15
    
    # Extra Bonus wenn langsamer
    score += 30 if target.pbSpeed > user.pbSpeed
    
    # Extra Bonus wenn KO möglich
    if move.damagingMove?
      rough_damage = calculate_rough_damage(move, user, target)
      score += 40 if rough_damage >= target.hp
    end
    
    return score
  end
  
  # Genauigkeit
  def score_accuracy(move, skill)
    accuracy = move.accuracy
    return 0 if accuracy == 0  # Never-miss moves
    
    if accuracy < 70
      return -40
    elsif accuracy < 85
      return -20
    elsif accuracy < 95
      return -10
    end
    
    return 0
  end
  
  # Recoil-Risiko
  def score_recoil_risk(move, user)
    return 0 unless move.recoil_damage > 0
    
    hp_percent = user.hp.to_f / user.totalhp
    
    if hp_percent < 0.3
      return -50  # Gefährlich bei niedriger HP
    elsif hp_percent < 0.5
      return -25
    else
      return -10  # Akzeptables Risiko
    end
  end
  
  # Sekundär-Effekte
  def score_secondary_effects(move, user, target)
    score = 0
    
    # Flinch
    if move.flinch_chance > 0
      score += 20 if user.pbSpeed > target.pbSpeed
    end
    
    # Stat Drops beim Gegner
    if move.stat_down.any?
      score += move.stat_down.values.sum * 5
    end
    
    # Status-Chance
    if move.status_inflicting_move? && target.status == :NONE
      score += move.status_chance / 2
    end
    
    return score
  end
  
  # === HELPER METHODS ===
  
  def calculate_rough_damage(move, user, target)
    return 0 unless move.damagingMove?
    
    # Sehr vereinfachte Schadens-Berechnung
    bp = move.base_damage
    return 0 if bp == 0
    
    atk = move.physicalMove? ? user.attack : user.spatk
    defense = move.physicalMove? ? target.defense : target.spdef
    
    type_mod = pbCalcTypeMod(move.type, target, user)
    stab = user.pbHasType?(move.type) ? 1.5 : 1.0
    
    damage = ((2 * user.level / 5.0 + 2) * bp * atk / defense / 50 + 2)
    damage *= type_mod
    damage *= stab
    
    return damage.to_i
  end
  
  def is_safe_to_setup?(user, target)
    # HP Check
    return false if user.hp < user.totalhp * 0.5
    
    # Speed Check
    return false if target.pbSpeed > user.pbSpeed * 1.5
    
    # Type Matchup Check
    target.moves.each do |move|
      next unless move && move.damagingMove?
      type_mod = pbCalcTypeMod(move.type, user, target)
      return false if Effectiveness.super_effective?(type_mod)
    end
    
    return true
  end
end

AdvancedAI.log("Move Scorer loaded", "Scorer")
