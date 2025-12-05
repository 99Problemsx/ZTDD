#===============================================================================
# [021] Battle Personalities - 4 AI Spielstile
#===============================================================================
# Definiert 4 verschiedene Battle-Personalities für variiertere KI
#
# Personalities:
# 1. AGGRESSIVE - Maximaler Schaden, riskante Plays
# 2. DEFENSIVE - Stalling, Walls, Recovery
# 3. BALANCED - Mix aus Offense/Defense
# 4. HYPER_OFFENSIVE - Setup Sweeps, alle-oder-nichts
#===============================================================================

module AdvancedAI
  module BattlePersonalities
    
    #===========================================================================
    # Personality Definitions
    #===========================================================================
    
    PERSONALITIES = {
      :aggressive => {
        name: "Aggressive",
        description: "Bevorzugt maximalen Schaden und riskante Plays",
        modifiers: {
          damage_bonus: 25,          # +25 für Damage-Moves
          setup_penalty: -20,        # -20 für Setup (zu langsam)
          healing_penalty: -30,      # -30 für Healing (defensive = schlecht)
          priority_bonus: 15,        # +15 für Priority Moves
          ohko_bonus: 40,            # +40 für OHKO Moves (riskant aber stark)
          switch_threshold: 55,      # Höhere Schwelle = weniger Switches
        }
      },
      
      :defensive => {
        name: "Defensive",
        description: "Bevorzugt Stalling, Walls und Recovery",
        modifiers: {
          damage_bonus: -10,         # -10 für Damage (nicht Priorität)
          setup_bonus: 20,           # +20 für Setup (Zeit ausspielen)
          healing_bonus: 40,         # +40 für Healing
          status_bonus: 30,          # +30 für Status Moves (Burn/Para)
          protect_bonus: 35,         # +35 für Protect (stalling)
          hazard_bonus: 25,          # +25 für Hazards
          switch_threshold: 35,      # Niedrige Schwelle = mehr Switches
        }
      },
      
      :balanced => {
        name: "Balanced",
        description: "Ausgewogener Mix aus Offense und Defense",
        modifiers: {
          damage_bonus: 10,          # +10 für Damage
          setup_bonus: 10,           # +10 für Setup
          healing_bonus: 15,         # +15 für Healing
          status_bonus: 15,          # +15 für Status
          switch_threshold: 45,      # Mittel
        }
      },
      
      :hyper_offensive => {
        name: "Hyper Offensive",
        description: "Setup Sweeps, alle-oder-nichts Strategie",
        modifiers: {
          damage_bonus: 15,          # +15 für Damage
          setup_bonus: 50,           # +50 für Setup (extreme Priorität)
          healing_penalty: -40,      # -40 für Healing (Zeit verschwendung)
          protect_bonus: 30,         # +30 für Protect (Setup absichern)
          spread_bonus: 20,          # +20 für Spread Moves (Doubles sweep)
          ohko_penalty: -20,         # -20 für OHKO (Setup besser)
          switch_threshold: 60,      # Sehr hoch = fast nie switchen
        }
      }
    }
    
    #===========================================================================
    # Personality Detection (basierend auf Pokemon-Team)
    #===========================================================================
    
    # Erkennt beste Personality für Trainer
    def self.detect_personality(battle, trainer_index)
      return :balanced if !battle
      
      party = battle.pbParty(trainer_index)
      return :balanced if !party || party.empty?
      
      # Zähle Pokemon-Rollen
      sweeper_count = 0
      wall_count = 0
      tank_count = 0
      support_count = 0
      
      party.each do |pokemon|
        next if !pokemon || pokemon.egg?
        
        roles = AdvancedAI.detect_roles(pokemon)
        next if !roles
        
        sweeper_count += 1 if roles.include?(:sweeper)
        wall_count += 1 if roles.include?(:wall)
        tank_count += 1 if roles.include?(:tank)
        support_count += 1 if roles.include?(:support)
      end
      
      total = party.count { |p| p && !p.egg? }
      
      # Hyper Offensive: Viele Sweepers + Setup
      if sweeper_count >= total * 0.6
        setup_count = 0
        party.each do |pokemon|
          next if !pokemon
          pokemon.moves.each do |move|
            setup_count += 1 if AdvancedAI.setup_move?(move.id)
          end
        end
        return :hyper_offensive if setup_count >= 4
      end
      
      # Defensive: Viele Walls + Recovery
      if wall_count >= total * 0.5
        return :defensive
      end
      
      # Aggressive: Hoher Damage, wenig Setup
      if sweeper_count >= total * 0.4 && wall_count <= 1
        return :aggressive
      end
      
      # Default: Balanced
      return :balanced
    end
    
    #===========================================================================
    # Apply Personality Modifiers
    #===========================================================================
    
    # Wendet Personality auf Move-Score an
    def self.apply_personality(score, move, personality)
      return score if !move || !personality
      return score if !PERSONALITIES.key?(personality)
      
      modifiers = PERSONALITIES[personality][:modifiers]
      return score if !modifiers
      
      # Damage Moves
      if move.category == :Physical || move.category == :Special
        score += modifiers[:damage_bonus] if modifiers[:damage_bonus]
      end
      
      # Setup Moves
      if AdvancedAI.setup_move?(move.id)
        score += modifiers[:setup_bonus] if modifiers[:setup_bonus]
        score += modifiers[:setup_penalty] if modifiers[:setup_penalty]
      end
      
      # Healing Moves
      if AdvancedAI.healing_move?(move.id)
        score += modifiers[:healing_bonus] if modifiers[:healing_bonus]
        score += modifiers[:healing_penalty] if modifiers[:healing_penalty]
      end
      
      # Status Moves
      if move.category == :Status && !AdvancedAI.setup_move?(move.id) && !AdvancedAI.healing_move?(move.id)
        score += modifiers[:status_bonus] if modifiers[:status_bonus]
      end
      
      # Priority Moves
      if move.priority > 0
        score += modifiers[:priority_bonus] if modifiers[:priority_bonus]
      end
      
      # OHKO Moves
      if AdvancedAI.ohko_move?(move.id)
        score += modifiers[:ohko_bonus] if modifiers[:ohko_bonus]
        score += modifiers[:ohko_penalty] if modifiers[:ohko_penalty]
      end
      
      # Protect Moves
      if AdvancedAI.protect_move?(move.id)
        score += modifiers[:protect_bonus] if modifiers[:protect_bonus]
      end
      
      # Hazard Moves
      if AdvancedAI.hazard_move?(move.id)
        score += modifiers[:hazard_bonus] if modifiers[:hazard_bonus]
      end
      
      # Spread Moves
      if AdvancedAI.spread_move?(move.id)
        score += modifiers[:spread_bonus] if modifiers[:spread_bonus]
      end
      
      return score
    end
    
    # Gibt Switch-Threshold für Personality zurück
    def self.get_switch_threshold(personality)
      return 45 if !personality || !PERSONALITIES.key?(personality)
      
      modifiers = PERSONALITIES[personality][:modifiers]
      return modifiers[:switch_threshold] || 45
    end
    
    #===========================================================================
    # Personality Descriptions
    #===========================================================================
    
    # Gibt Personality-Name zurück
    def self.get_name(personality)
      return "Balanced" if !personality || !PERSONALITIES.key?(personality)
      return PERSONALITIES[personality][:name]
    end
    
    # Gibt Personality-Beschreibung zurück
    def self.get_description(personality)
      return "" if !personality || !PERSONALITIES.key?(personality)
      return PERSONALITIES[personality][:description]
    end
    
    #===========================================================================
    # Personality Override (für Event-Kämpfe)
    #===========================================================================
    
    # Manuelle Personality-Zuweisung
    @personality_overrides = {}
    
    def self.set_personality(trainer_name, personality)
      return if !trainer_name || !personality
      return if !PERSONALITIES.key?(personality)
      
      @personality_overrides[trainer_name] = personality
      AdvancedAI.log("[Personality] Set #{trainer_name} to #{get_name(personality)}", :personality)
    end
    
    def self.get_personality(battle, trainer_index)
      return :balanced if !battle
      
      # Check override
      trainer = battle.pbGetOwnerFromBattlerIndex(trainer_index)
      if trainer && @personality_overrides[trainer.name]
        return @personality_overrides[trainer.name]
      end
      
      # Auto-detect
      return detect_personality(battle, trainer_index)
    end
    
  end
end

#===============================================================================
# API Wrapper
#===============================================================================
module AdvancedAI
  def self.detect_personality(battle, trainer_index)
    BattlePersonalities.detect_personality(battle, trainer_index)
  end
  
  def self.apply_personality(score, move, personality)
    BattlePersonalities.apply_personality(score, move, personality)
  end
  
  def self.get_personality(battle, trainer_index)
    BattlePersonalities.get_personality(battle, trainer_index)
  end
  
  def self.set_personality(trainer_name, personality)
    BattlePersonalities.set_personality(trainer_name, personality)
  end
  
  def self.get_personality_switch_threshold(personality)
    BattlePersonalities.get_switch_threshold(personality)
  end
end
