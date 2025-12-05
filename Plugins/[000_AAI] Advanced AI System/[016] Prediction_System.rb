#===============================================================================
# [016] Prediction System - Switch & Move Prediction
#===============================================================================
# Vorhersage von Gegner-Aktionen basierend auf Move Memory und Patterns
#
# Features:
# - Switch Prediction (wann wechselt Gegner?)
# - Move Prediction (welche Attacke kommt?)
# - Pattern Recognition (erkennt Spieler-Muster)
# - Double Switch Detection (Predict + Counter)
#===============================================================================

module AdvancedAI
  module PredictionSystem
    
    #===========================================================================
    # Switch Prediction
    #===========================================================================
    
    # Berechnet Wahrscheinlichkeit dass Gegner wechselt (0-100%)
    def self.predict_switch_chance(battle, opponent)
      return 0 if !battle || !opponent
      
      chance = 0
      
      # 1. Typ-Nachteil (+30%)
      user = battle.battlers[(opponent.index + 2) % 4]  # Gegenüber
      if user
        memory = AdvancedAI.get_memory(battle, user)
        if memory && memory[:moves_seen]
          memory[:moves_seen].each do |move_id|
            move = GameData::Move.try_get(move_id)
            next if !move
            
            effectiveness = Effectiveness.calculate(move.type, opponent.type1, opponent.type2)
            if Effectiveness.super_effective?(effectiveness)
              chance += 30
              break
            end
          end
        end
      end
      
      # 2. Niedrige HP (+25%)
      if opponent.hp < opponent.totalhp * 0.3
        chance += 25
      elsif opponent.hp < opponent.totalhp * 0.5
        chance += 15
      end
      
      # 3. Stat Drops (-2 oder schlechter = +20%)
      if opponent.stages[:ATTACK] <= -2 || opponent.stages[:SPECIAL_ATTACK] <= -2
        chance += 20
      end
      
      if opponent.stages[:SPEED] <= -2
        chance += 15
      end
      
      # 4. Status-Probleme (+15%)
      if opponent.status == :BURN || opponent.status == :POISON || opponent.status == :TOXIC
        chance += 15
      end
      
      if opponent.status == :PARALYSIS
        chance += 10
      end
      
      # 5. Keine effektiven Moves mehr (+20%)
      if opponent.moves.all? { |m| m && m.pp == 0 }
        chance += 50  # Struggle forced
      end
      
      # 6. Kürzlich gewechselt? (-30%)
      # (Spieler wechselt selten direkt zurück)
      if opponent.turnCount <= 1
        chance -= 30
      end
      
      # Cap bei 0-95%
      chance = [[chance, 95].min, 0].max
      
      return chance
    end
    
    # Gibt wahrscheinlichsten Switch-Target zurück
    def self.predict_switch_target(battle, opponent)
      return nil if !battle || !opponent
      
      # Finde beste Counter im Team
      party = battle.pbParty(opponent.index % 2)
      return nil if !party
      
      best_counter = nil
      best_score = 0
      
      user = battle.battlers[(opponent.index + 2) % 4]
      return nil if !user
      
      party.each_with_index do |pokemon, i|
        next if !pokemon || pokemon.fainted? || pokemon.egg?
        next if pokemon == opponent.pokemon  # Nicht aktuelles Pokemon
        
        score = 0
        
        # Typ-Matchup
        user.moves.each do |move|
          next if !move
          effectiveness = Effectiveness.calculate(move.type, pokemon.type1, pokemon.type2)
          
          if Effectiveness.not_very_effective?(effectiveness) || Effectiveness.ineffective?(effectiveness)
            score += 30
          elsif Effectiveness.super_effective?(effectiveness)
            score -= 20
          end
        end
        
        # Pokemon ist unverletzt? (+20)
        score += 20 if pokemon.hp == pokemon.totalhp
        
        # Pokemon ist Wall/Tank? (+15)
        roles = AdvancedAI.detect_roles(pokemon)
        score += 15 if roles.include?(:wall) || roles.include?(:tank)
        
        if score > best_score
          best_score = score
          best_counter = pokemon
        end
      end
      
      return best_counter
    end
    
    #===========================================================================
    # Move Prediction
    #===========================================================================
    
    # Berechnet wahrscheinlichste Move (basierend auf Memory)
    def self.predict_next_move(battle, opponent)
      return nil if !battle || !opponent
      
      memory = AdvancedAI.get_memory(battle, opponent)
      return nil if !memory || !memory[:move_frequency]
      
      # Finde meist-genutzte Move
      most_used = nil
      highest_count = 0
      
      memory[:move_frequency].each do |move_id, count|
        if count > highest_count
          highest_count = count
          most_used = move_id
        end
      end
      
      # Aber: Last Move Repeat ist unwahrscheinlich
      if memory[:last_move] && most_used == memory[:last_move]
        # Finde zweithäufigste
        second_most = nil
        second_count = 0
        
        memory[:move_frequency].each do |move_id, count|
          next if move_id == most_used
          if count > second_count
            second_count = count
            second_most = move_id
          end
        end
        
        most_used = second_most if second_most
      end
      
      return most_used
    end
    
    # Bewertet Move basierend auf Vorhersage
    def self.score_prediction_bonus(battle, user, target, move, predicted_move)
      return 0 if !battle || !user || !target || !move || !predicted_move
      
      bonus = 0
      predicted_move_data = GameData::Move.try_get(predicted_move)
      return 0 if !predicted_move_data
      
      # 1. Protect gegen starke Attacke (+40)
      if AdvancedAI.protect_move?(move.id)
        if predicted_move_data.base_damage >= 80
          bonus += 40
        end
        
        # Extra Bonus gegen Setup
        if AdvancedAI.setup_move?(predicted_move)
          bonus += 20  # Block setup mit Protect
        end
      end
      
      # 2. Resistenz gegen vorhergesagten Move (+25)
      if move.category != :Status
        effectiveness = Effectiveness.calculate(predicted_move_data.type, user.type1, user.type2)
        if Effectiveness.not_very_effective?(effectiveness) || Effectiveness.ineffective?(effectiveness)
          bonus += 25
        end
      end
      
      # 3. Counter-Move (+35)
      # Z.B. Gegner nutzt Physical Move → Burn
      if move.id == :WILLOWISP && predicted_move_data.physicalMove?
        bonus += 35
      end
      
      # Gegner nutzt Status Move → Taunt
      if move.id == :TAUNT && predicted_move_data.category == :Status
        bonus += 35
      end
      
      # 4. Switch bei vorhergesagtem OHKO (+50)
      if predicted_move_data.base_damage >= 100
        damage = calculate_predicted_damage(target, user, predicted_move_data)
        if damage >= user.hp
          # Nutze Pivot move oder Protect
          bonus += 50 if AdvancedAI.pivot_move?(move.id)
          bonus += 45 if AdvancedAI.protect_move?(move.id)
        end
      end
      
      return bonus
    end
    
    #===========================================================================
    # Pattern Recognition
    #===========================================================================
    
    # Erkennt Spieler-Muster
    @battle_patterns = {}
    
    def self.track_pattern(battle, trainer_name, action)
      return if !battle || !trainer_name || !action
      
      @battle_patterns[trainer_name] ||= []
      @battle_patterns[trainer_name] << {
        turn: battle.turnCount,
        action: action
      }
      
      # Behalte nur letzte 20 Aktionen
      @battle_patterns[trainer_name] = @battle_patterns[trainer_name].last(20)
    end
    
    # Prüft ob Spieler Pattern zeigt
    def self.detect_pattern(trainer_name, pattern_type)
      return false if !trainer_name || !@battle_patterns[trainer_name]
      
      patterns = @battle_patterns[trainer_name]
      return false if patterns.size < 3
      
      case pattern_type
      when :always_setup_turn1
        # Prüft ob Spieler immer Turn 1 setup macht
        turn1_actions = patterns.select { |p| p[:turn] == 1 }
        return false if turn1_actions.empty?
        
        setup_count = turn1_actions.count { |p| p[:action] == :setup }
        return setup_count >= turn1_actions.size * 0.8
        
      when :switches_on_disadvantage
        # Prüft ob Spieler bei Nachteil wechselt
        disadvantage_switches = patterns.count { |p| p[:action] == :switch_on_disadvantage }
        return disadvantage_switches >= 3
        
      when :always_attack
        # Prüft ob Spieler fast nie Status benutzt
        attack_count = patterns.count { |p| p[:action] == :attack }
        return attack_count >= patterns.size * 0.9
      end
      
      return false
    end
    
    #===========================================================================
    # Double Switch Detection
    #===========================================================================
    
    # Berechnet ob double switch sinnvoll ist
    def self.should_double_switch?(battle, user, predicted_switch)
      return false if !battle || !user || !predicted_switch
      
      # Double Switch: AI wechselt auf Pokemon das predicted_switch countered
      
      # Finde besten Counter für predicted_switch
      party = battle.pbParty(user.index % 2)
      return false if !party
      
      best_counter = nil
      best_score = 0
      
      party.each do |pokemon|
        next if !pokemon || pokemon.fainted? || pokemon.egg?
        next if pokemon == user.pokemon
        
        score = 0
        
        # Typ-Vorteil
        pokemon.moves.each do |move|
          next if !move
          effectiveness = Effectiveness.calculate(move.type, predicted_switch.type1, predicted_switch.type2)
          score += 40 if Effectiveness.super_effective?(effectiveness)
        end
        
        # Resistiert predicted_switch moves?
        predicted_switch.moves.each do |move|
          next if !move
          effectiveness = Effectiveness.calculate(move.type, pokemon.type1, pokemon.type2)
          score += 20 if Effectiveness.not_very_effective?(effectiveness)
          score += 30 if Effectiveness.ineffective?(effectiveness)
        end
        
        if score > best_score
          best_score = score
          best_counter = pokemon
        end
      end
      
      # Double switch wenn Score > 60
      return best_score >= 60
    end
    
    #===========================================================================
    # Helper Methods
    #===========================================================================
    
    def self.calculate_predicted_damage(attacker, defender, move)
      return 0 if !attacker || !defender || !move
      
      attack = move.physicalMove? ? attacker.attack : attacker.spatk
      defense = move.physicalMove? ? defender.defense : defender.spdef
      
      effectiveness = Effectiveness.calculate(move.type, defender.type1, defender.type2)
      multiplier = Effectiveness.calculate_multiplier(effectiveness)
      
      damage = ((2 * attacker.level / 5 + 2) * move.base_damage * attack / defense / 50 + 2) * multiplier
      return damage.to_i
    end
    
  end
end

#===============================================================================
# API Wrapper
#===============================================================================
module AdvancedAI
  def self.predict_switch_chance(battle, opponent)
    PredictionSystem.predict_switch_chance(battle, opponent)
  end
  
  def self.predict_switch_target(battle, opponent)
    PredictionSystem.predict_switch_target(battle, opponent)
  end
  
  def self.predict_next_move(battle, opponent)
    PredictionSystem.predict_next_move(battle, opponent)
  end
  
  def self.score_prediction_bonus(battle, user, target, move, predicted_move)
    PredictionSystem.score_prediction_bonus(battle, user, target, move, predicted_move)
  end
  
  def self.track_pattern(battle, trainer_name, action)
    PredictionSystem.track_pattern(battle, trainer_name, action)
  end
  
  def self.detect_pattern(trainer_name, pattern_type)
    PredictionSystem.detect_pattern(trainer_name, pattern_type)
  end
  
  def self.should_double_switch?(battle, user, predicted_switch)
    PredictionSystem.should_double_switch?(battle, user, predicted_switch)
  end
end
