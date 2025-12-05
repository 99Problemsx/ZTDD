#===============================================================================
# [020] Endgame Scenarios - 1v1/2v2 Logic
#===============================================================================
# Spezielle Strategien für Endgame-Situationen
#
# Features:
# - 1v1 Optimize (nur noch 1 Pokemon pro Seite)
# - 2v2 Optimize (2v2 Situation)
# - Winning Move Detection (garantierter KO)
# - Stall Detection (Zeit rausspielen)
# - Desperation Moves (letzter Versuch)
#===============================================================================

module AdvancedAI
  module EndgameScenarios
    
    #===========================================================================
    # Endgame Detection
    #===========================================================================
    
    # Prüft ob Endgame (≤2 Pokemon pro Seite)
    def self.is_endgame?(battle)
      return false if !battle
      
      # Zähle verbleibende Pokemon
      side0_count = battle.pbAbleNonActiveCount(0) + battle.pbParty(0).count { |p| p && !p.fainted? && p.hp > 0 }
      side1_count = battle.pbAbleNonActiveCount(1) + battle.pbParty(1).count { |p| p && !p.fainted? && p.hp > 0 }
      
      return side0_count <= 2 || side1_count <= 2
    end
    
    # Prüft ob 1v1 (nur noch 1 Pokemon pro Seite aktiv)
    def self.is_1v1?(battle)
      return false if !battle
      
      side0_count = battle.pbAbleCount(0)
      side1_count = battle.pbAbleCount(1)
      
      return side0_count == 1 && side1_count == 1
    end
    
    # Prüft ob 2v2 (2 Pokemon pro Seite)
    def self.is_2v2?(battle)
      return false if !battle
      
      side0_count = battle.pbAbleCount(0)
      side1_count = battle.pbAbleCount(1)
      
      return side0_count == 2 && side1_count == 2
    end
    
    #===========================================================================
    # 1v1 Optimization
    #===========================================================================
    
    # Bewertet Move für 1v1
    def self.score_1v1_move(battle, user, target, move, base_score)
      return base_score if !battle || !user || !target || !move
      return base_score if !is_1v1?(battle)
      
      score = base_score
      
      # 1. KO Priority (Winning Move = +100)
      if can_ko?(user, target, move)
        AdvancedAI.log("  [Endgame] 1v1: Move can KO! +100", :endgame)
        score += 100
      end
      
      # 2. 2HKO Priority (+50)
      if can_2hko?(user, target, move)
        AdvancedAI.log("  [Endgame] 1v1: Move can 2HKO! +50", :endgame)
        score += 50
      end
      
      # 3. Speed Control
      if user.pbSpeed < target.pbSpeed
        # Langsamer = Priority Moves sehr wertvoll
        if move.priority > 0
          AdvancedAI.log("  [Endgame] 1v1: Priority move (slower) +60", :endgame)
          score += 60
        end
        
        # Langsamer = Setup gefährlich
        if AdvancedAI.setup_move?(move.id)
          AdvancedAI.log("  [Endgame] 1v1: Setup risky (slower) -40", :endgame)
          score -= 40
        end
      else
        # Schneller = Setup sicherer
        if AdvancedAI.setup_move?(move.id)
          AdvancedAI.log("  [Endgame] 1v1: Setup safe (faster) +20", :endgame)
          score += 20
        end
      end
      
      # 4. Survival Moves
      if user.hp < user.totalhp * 0.3
        # Protect wertvoll wenn schwach
        if AdvancedAI.protect_move?(move.id)
          score += 40
        end
        
        # Healing kritisch
        if AdvancedAI.healing_move?(move.id)
          score += 60
        end
      end
      
      # 5. Status Moves in 1v1
      if move.category == :Status
        # Will-O-Wisp/Thunder Wave sehr stark
        if [:WILLOWISP, :THUNDERWAVE, :TOXIC].include?(move.id)
          # Aber nur wenn target noch nicht status hat
          if !target.status
            score += 40
          end
        end
        
        # Setup = riskant aber kann gewinnen
        if AdvancedAI.setup_move?(move.id)
          # +20 wenn user surviven kann
          if user.hp > user.totalhp * 0.7
            score += 20
          end
        end
      end
      
      # 6. OHKO Moves (desperate)
      if AdvancedAI.ohko_move?(move.id)
        # 30% Chance = besser als verlieren
        score += 80
      end
      
      return score
    end
    
    #===========================================================================
    # 2v2 Optimization
    #===========================================================================
    
    # Bewertet Move für 2v2
    def self.score_2v2_move(battle, user, target, move, base_score)
      return base_score if !battle || !user || !target || !move
      return base_score if !is_2v2?(battle)
      
      score = base_score
      
      # 1. Focus Fire (beide auf schwächstes Target)
      weakest = find_weakest_opponent(battle, user)
      if weakest && target.index == weakest.index
        AdvancedAI.log("  [Endgame] 2v2: Targeting weakest +40", :endgame)
        score += 40
      end
      
      # 2. Protect Stalling (warte auf Partner-KO)
      if AdvancedAI.protect_move?(move.id)
        partner = get_partner(battle, user)
        if partner
          # Prüfe ob Partner KO schaffen kann
          partner.moves.each do |partner_move|
            next if !partner_move
            if can_ko?(partner, target, partner_move)
              AdvancedAI.log("  [Endgame] 2v2: Protect for partner KO +50", :endgame)
              score += 50
              break
            end
          end
        end
      end
      
      # 3. Spread Moves weniger wert (nur 2 Ziele)
      if AdvancedAI.spread_move?(move.id)
        AdvancedAI.log("  [Endgame] 2v2: Spread move limited -20", :endgame)
        score -= 20
      end
      
      # 4. Priority für sichere KOs
      if can_ko?(user, target, move)
        AdvancedAI.log("  [Endgame] 2v2: Secure KO +80", :endgame)
        score += 80
      end
      
      return score
    end
    
    #===========================================================================
    # Winning Move Detection
    #===========================================================================
    
    # Prüft ob Move für garantierten Sieg sorgt
    def self.winning_move?(battle, user, move)
      return false if !battle || !user || !move
      
      # Alle Gegner-Pokemon KO-bar?
      opponents = battle.allOtherSideBattlers(user.index)
      return false if opponents.empty?
      
      ko_count = 0
      opponents.each do |opp|
        next if !opp || opp.fainted?
        ko_count += 1 if can_ko?(user, opp, move)
      end
      
      # Winning wenn alle aktiven Gegner KO-bar
      active_opponents = opponents.count { |opp| opp && !opp.fainted? }
      return ko_count >= active_opponents
    end
    
    # Findet Winning Move (wenn existiert)
    def self.find_winning_move(battle, user)
      return nil if !battle || !user
      
      user.moves.each do |move|
        next if !move || move.pp <= 0
        return move.id if winning_move?(battle, user, move)
      end
      
      return nil
    end
    
    #===========================================================================
    # Stall Detection
    #===========================================================================
    
    # Prüft ob Stalling sinnvoll ist
    def self.should_stall?(battle, user)
      return false if !battle || !user
      
      # Stalling nur in Endgame sinnvoll
      return false if !is_endgame?(battle)
      
      # Voraussetzungen für Stalling:
      # 1. User hat Recovery
      # 2. User hat defensive Stats
      # 3. Gegner kann nicht OHKO
      
      has_recovery = false
      user.moves.each do |move|
        next if !move
        has_recovery = true if AdvancedAI.healing_move?(move.id)
      end
      
      return false if !has_recovery
      
      # Check defensive stats
      roles = AdvancedAI.detect_roles(user)
      return false if !roles.include?(:wall) && !roles.include?(:tank)
      
      # Check ob Gegner OHKO kann
      opponents = battle.allOtherSideBattlers(user.index)
      opponents.each do |opp|
        next if !opp || opp.fainted?
        
        # Wenn Gegner sehr stark = kein Stalling
        if opp.attack >= 140 || opp.spatk >= 140
          return false
        end
      end
      
      return true
    end
    
    #===========================================================================
    # Desperation Moves
    #===========================================================================
    
    # Bonus für verzweifelte Moves
    def self.desperation_bonus(battle, user, move)
      return 0 if !battle || !user || !move
      
      # Nur wenn kurz vorm Verlieren
      remaining = battle.pbAbleCount(user.index)
      return 0 if remaining > 1
      
      # Nur wenn user schwach
      return 0 if user.hp > user.totalhp * 0.3
      
      bonus = 0
      
      # OHKO Moves (+80)
      bonus += 80 if AdvancedAI.ohko_move?(move.id)
      
      # Explosion/Self-Destruct (+60)
      bonus += 60 if [:EXPLOSION, :SELFDESTRUCT].include?(move.id)
      
      # Final Gambit (+50)
      bonus += 50 if move.id == :FINALGAMBIT
      
      # Reversal / Flail (stark bei low HP) (+40)
      bonus += 40 if [:REVERSAL, :FLAIL].include?(move.id)
      
      return bonus
    end
    
    #===========================================================================
    # Helper Methods
    #===========================================================================
    
    # Prüft ob Move KO schafft
    def self.can_ko?(user, target, move)
      return false if !user || !target || !move
      
      # Rough damage calculation
      damage = calculate_rough_damage(user, target, move)
      return damage >= target.hp
    end
    
    # Prüft ob Move 2HKO schafft
    def self.can_2hko?(user, target, move)
      return false if !user || !target || !move
      
      damage = calculate_rough_damage(user, target, move)
      return damage * 2 >= target.hp
    end
    
    # Rough Damage Calculation
    def self.calculate_rough_damage(user, target, move)
      return 0 if !user || !target || !move
      return 0 if move.category == :Status
      
      # Sehr vereinfacht (für AI reicht das)
      attack = (move.physicalMove? ? user.attack : user.spatk)
      defense = (move.physicalMove? ? target.defense : target.spdef)
      
      # Type effectiveness
      effectiveness = Effectiveness.calculate(move.type, target.type1, target.type2)
      multiplier = Effectiveness.calculate_multiplier(effectiveness)
      
      # Rough formula
      damage = ((2 * user.level / 5 + 2) * move.base_damage * attack / defense / 50 + 2) * multiplier
      
      return damage.to_i
    end
    
    # Findet schwächsten Gegner
    def self.find_weakest_opponent(battle, user)
      return nil if !battle || !user
      
      opponents = battle.allOtherSideBattlers(user.index)
      return nil if opponents.empty?
      
      weakest = nil
      lowest_hp_percent = 999
      
      opponents.each do |opp|
        next if !opp || opp.fainted?
        
        hp_percent = (opp.hp * 100.0 / opp.totalhp)
        if hp_percent < lowest_hp_percent
          lowest_hp_percent = hp_percent
          weakest = opp
        end
      end
      
      return weakest
    end
    
    # Gibt Partner zurück (Doubles)
    def self.get_partner(battle, user)
      return nil if !battle || !user
      return nil if !battle.pbSideSize(0) > 1  # Not doubles
      
      partner_index = (user.index % 2 == 0) ? user.index + 1 : user.index - 1
      partner = battle.battlers[partner_index]
      
      return partner if partner && !partner.fainted?
      return nil
    end
    
  end
end

#===============================================================================
# API Wrapper
#===============================================================================
module AdvancedAI
  def self.is_endgame?(battle)
    EndgameScenarios.is_endgame?(battle)
  end
  
  def self.is_1v1?(battle)
    EndgameScenarios.is_1v1?(battle)
  end
  
  def self.is_2v2?(battle)
    EndgameScenarios.is_2v2?(battle)
  end
  
  def self.score_endgame_move(battle, user, target, move, base_score)
    score = base_score
    score = EndgameScenarios.score_1v1_move(battle, user, target, move, score) if EndgameScenarios.is_1v1?(battle)
    score = EndgameScenarios.score_2v2_move(battle, user, target, move, score) if EndgameScenarios.is_2v2?(battle)
    return score
  end
  
  def self.find_winning_move(battle, user)
    EndgameScenarios.find_winning_move(battle, user)
  end
  
  def self.should_stall?(battle, user)
    EndgameScenarios.should_stall?(battle, user)
  end
  
  def self.desperation_bonus(battle, user, move)
    EndgameScenarios.desperation_bonus(battle, user, move)
  end
end
