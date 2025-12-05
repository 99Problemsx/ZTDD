#===============================================================================
# Advanced AI System - Threat Assessment
# Bewertet Gefahrenlevel basierend auf Stats, Moves, Abilities, Items
#===============================================================================

module AdvancedAI
  module ThreatAssessment
    # Hauptfunktion: Bewertet Bedrohung (0-10 Skala)
    def self.assess_threat(battle, attacker, opponent, skill_level = 100)
      return 5 unless battle && attacker && opponent && !opponent.fainted?
      
      threat = 5.0  # Base threat
      
      # 1. STAT-BASIERTE BEDROHUNG (0-2.5)
      threat += assess_stat_threat(attacker, opponent)
      
      # 2. TYP-MATCHUP (0-2.0)
      threat += assess_type_threat(attacker, opponent)
      
      # 3. MOVE-BASIERTE BEDROHUNG (0-2.0)
      if skill_level >= 50
        threat += assess_move_threat(battle, attacker, opponent)
      end
      
      # 4. ABILITY-BASIERTE BEDROHUNG (0-1.5)
      if skill_level >= 60
        threat += assess_ability_threat(attacker, opponent)
      end
      
      # 5. HP-BASIERTE MODIFIKATION (x0.3 - x1.2)
      threat *= assess_hp_modifier(opponent)
      
      # 6. SETUP-BEDROHUNG (0-1.5)
      if skill_level >= 55
        threat += assess_setup_threat(opponent)
      end
      
      # 7. SPEED-BEDROHUNG (0-1.0)
      threat += assess_speed_threat(attacker, opponent)
      
      return [[threat, 0].max, 10].min  # Clamp 0-10
    end
    
    private
    
    # Stat-basierte Bedrohung
    def self.assess_stat_threat(attacker, opponent)
      threat = 0.0
      
      # Offensive Stats
      if opponent.attack > attacker.defense * 1.5
        threat += 1.0
      elsif opponent.attack > attacker.defense
        threat += 0.5
      end
      
      if opponent.spatk > attacker.spdef * 1.5
        threat += 1.0
      elsif opponent.spatk > attacker.spdef
        threat += 0.5
      end
      
      return [threat, 2.5].min
    end
    
    # Typ-Matchup Bedrohung
    def self.assess_type_threat(attacker, opponent)
      threat = 0.0
      
      # Prüfe Typ-Vorteil des Gegners
      opponent_types = [opponent.types[0], opponent.types[1]].compact.uniq
      attacker_types = [attacker.types[0], attacker.types[1]].compact.uniq
      
      opponent_types.each do |opp_type|
        attacker_types.each do |att_type|
          effectiveness = Effectiveness.calculate(opp_type, att_type, nil)
          
          if Effectiveness.super_effective?(effectiveness)
            threat += 1.0
          elsif Effectiveness.not_very_effective?(effectiveness)
            threat -= 0.5
          elsif Effectiveness.ineffective?(effectiveness)
            threat -= 1.0
          end
        end
      end
      
      return [threat, 2.0].min
    end
    
    # Move-basierte Bedrohung
    def self.assess_move_threat(battle, attacker, opponent)
      threat = 0.0
      memory = AdvancedAI::MoveMemory.get_memory(battle, opponent)
      
      # Bekannte Moves analysieren
      if memory[:moves]
        memory[:moves].each do |move_id|
          move_data = GameData::Move.get(move_id)
          
          # Priority Moves
          threat += 0.5 if move_data.priority > 0
          
          # Super Effective Coverage
          if move_data.damagingMove?
            attacker_types = [attacker.types[0], attacker.types[1]].compact.uniq
            attacker_types.each do |type|
              effectiveness = Effectiveness.calculate(move_data.type, type, nil)
              threat += 0.8 if Effectiveness.super_effective?(effectiveness)
            end
          end
          
          # OHKO Moves
          threat += 1.0 if [:GUILLOTINE, :FISSURE, :SHEERCOLD, :HORNDRILL].include?(move_id)
          
          # Setup Moves
          threat += 0.3 if move_data.stat_up.any?
        end
      end
      
      # Max bekannter Schaden
      max_damage = AdvancedAI::MoveMemory.max_known_damage(battle, opponent, attacker)
      if max_damage > attacker.hp * 0.8
        threat += 1.0
      elsif max_damage > attacker.hp * 0.5
        threat += 0.5
      end
      
      return [threat, 2.0].min
    end
    
    # Ability-basierte Bedrohung
    def self.assess_ability_threat(attacker, opponent)
      threat = 0.0
      ability = opponent.ability_id
      
      return 0.0 unless ability
      
      # Extreme Offensive Abilities
      if [:HUGEPOWER, :PUREPOWER, :PARENTALBOND, :GORILLATAR, :PROTOSYNTHESIS, :QUARKDRIVE].include?(ability)
        threat += 1.5
      end
      
      # Strong Offensive Abilities
      if [:ADAPTABILITY, :SHEERFORCE, :TECHNICIAN, :SKILLLINK, :STRONGJAW, :TOUGHCLAWS, :SHARPNESS].include?(ability)
        threat += 0.8
      end
      
      # Priority Abilities
      if [:GALEWINGS, :PRANKSTER, :QUICKDRAW].include?(ability)
        threat += 0.6
      end
      
      # Speed Boost
      if [:SPEEDBOOST, :UNBURDEN, :MOTORDRIVE].include?(ability)
        threat += 0.5
      end
      
      # Defensive Abilities (reduzieren Bedrohung)
      if [:WONDERGUARD, :MULTISCALE, :REGENERATOR, :MAGICBOUNCE].include?(ability)
        threat += 0.3
      end
      
      return [threat, 1.5].min
    end
    
    # HP-Modifier
    def self.assess_hp_modifier(opponent)
      hp_percent = opponent.hp.to_f / opponent.totalhp
      
      if hp_percent < 0.2
        return 0.3  # Fast besiegt
      elsif hp_percent < 0.4
        return 0.6
      elsif hp_percent < 0.6
        return 0.8
      elsif hp_percent > 0.9
        return 1.2  # Volle Power
      else
        return 1.0
      end
    end
    
    # Setup-Bedrohung
    def self.assess_setup_threat(opponent)
      threat = 0.0
      
      # Stat Boosts
      [:ATTACK, :SPECIAL_ATTACK, :SPEED].each do |stat|
        stage = opponent.stages[stat]
        threat += stage * 0.3 if stage > 0
      end
      
      return [threat, 1.5].min
    end
    
    # Speed-Bedrohung
    def self.assess_speed_threat(attacker, opponent)
      return 0.0 if opponent.pbSpeed <= attacker.pbSpeed
      
      speed_ratio = opponent.pbSpeed.to_f / attacker.pbSpeed
      
      if speed_ratio > 2.0
        return 1.0
      elsif speed_ratio > 1.5
        return 0.7
      else
        return 0.4
      end
    end
    
    public
    
    # Findet bedrohlischsten Gegner
    def self.most_threatening_opponent(battle, attacker, skill_level = 100)
      return nil unless battle && attacker
      
      opponents = battle.allOtherSideBattlers(attacker.index).select { |b| b && !b.fainted? }
      return nil if opponents.empty?
      
      threats = opponents.map do |opp|
        [opp, assess_threat(battle, attacker, opp, skill_level)]
      end
      
      threats.max_by { |opp, threat| threat }&.first
    end
    
    # Priorisiert Ziel in Doubles
    def self.priority_target(battle, attacker, opp1, opp2, skill_level = 100)
      return opp1 unless opp2
      return opp2 unless opp1
      
      threat1 = assess_threat(battle, attacker, opp1, skill_level)
      threat2 = assess_threat(battle, attacker, opp2, skill_level)
      
      AdvancedAI.log("#{opp1.pbThis}: #{threat1.round(2)} threat vs #{opp2.pbThis}: #{threat2.round(2)} threat", "Threat")
      
      threat1 >= threat2 ? opp1 : opp2
    end
  end
end

# API-Wrapper
module AdvancedAI
  def self.assess_threat(battle, attacker, opponent, skill_level = 100)
    ThreatAssessment.assess_threat(battle, attacker, opponent, skill_level)
  end
  
  def self.most_threatening_opponent(battle, attacker, skill_level = 100)
    ThreatAssessment.most_threatening_opponent(battle, attacker, skill_level)
  end
  
  def self.priority_target(battle, attacker, opp1, opp2, skill_level = 100)
    ThreatAssessment.priority_target(battle, attacker, opp1, opp2, skill_level)
  end
end

# Integration in Battle::AI
class Battle::AI
  def apply_threat_assessment(score, move, user, target)
    skill = @trainer&.skill || 100
    return score unless AdvancedAI.feature_enabled?(:core, skill)
    return score unless target
    
    # user is AIBattler, need real battler for threat assessment
    real_user = user.respond_to?(:battler) ? user.battler : user
    real_target = target.respond_to?(:battler) ? target.battler : target
    
    threat = AdvancedAI.assess_threat(@battle, real_user, real_target, skill)
    
    # Höhere Bedrohung = höherer Score für Angriff
    if move.damagingMove?
      score += (threat * 5).to_i  # 0-50 Punkte
    end
    
    # Niedrige Bedrohung = Switch erwägen
    if threat < 3.0 && skill >= 50
      score -= 15  # Andere Ziele attraktiver
    end
    
    return score
  end
end

AdvancedAI.log("Threat Assessment System loaded", "Threat")
