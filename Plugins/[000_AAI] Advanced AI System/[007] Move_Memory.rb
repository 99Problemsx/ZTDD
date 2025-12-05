#===============================================================================
# Advanced AI System - Move Memory
# Trackt alle Gegner-Züge für intelligente Vorhersagen (Reborn-inspired)
#===============================================================================

module AdvancedAI
  module MoveMemory
    # Cache für Move Memory pro Battle
    @battle_memory = {}
    
    # Initialisiert Move Memory für einen Battle
    def self.initialize_battle(battle)
      @battle_memory[battle.object_id] ||= {}
    end
    
    # Speichert einen Move
    def self.remember_move(battle, battler, move)
      return unless battle && battler && move
      initialize_battle(battle)
      
      battler_key = "#{battler.index}_#{battler.pokemon.personalID}"
      @battle_memory[battle.object_id][battler_key] ||= {
        moves: [],
        move_counts: Hash.new(0),
        last_move: nil,
        priority_moves: [],
        healing_moves: [],
        setup_moves: [],
        status_moves: [],
        max_power: 0
      }
      
      memory = @battle_memory[battle.object_id][battler_key]
      move_id = move.id
      
      # Speichere Move
      memory[:moves] << move_id unless memory[:moves].include?(move_id)
      memory[:move_counts][move_id] += 1
      memory[:last_move] = move_id
      
      # Kategorisiere Move
      move_data = GameData::Move.get(move_id)
      memory[:priority_moves] << move_id if move_data.priority > 0 && !memory[:priority_moves].include?(move_id)
      memory[:healing_moves] << move_id if move_data.healing_move? && !memory[:healing_moves].include?(move_id)
      memory[:setup_moves] << move_id if move_data.stat_up.any? && !memory[:setup_moves].include?(move_id)
      memory[:status_moves] << move_id if move_data.statusMove? && !memory[:status_moves].include?(move_id)
      memory[:max_power] = [memory[:max_power], move_data.base_damage].max
      
      AdvancedAI.log("Remembered move #{move_id} for #{battler.pbThis}", "Memory")
    end
    
    # Holt Memory für einen Battler
    def self.get_memory(battle, battler)
      return {} unless battle && battler
      initialize_battle(battle)
      
      battler_key = "#{battler.index}_#{battler.pokemon.personalID}"
      @battle_memory[battle.object_id][battler_key] || {}
    end
    
    # Prüft ob Move bekannt ist
    def self.knows_move?(battle, battler, move_id)
      memory = get_memory(battle, battler)
      memory[:moves]&.include?(move_id) || false
    end
    
    # Prüft ob Battler Priority Moves hat
    def self.has_priority_move?(battle, battler)
      memory = get_memory(battle, battler)
      !memory[:priority_moves].nil? && memory[:priority_moves].any?
    end
    
    # Prüft ob Battler Healing Moves hat
    def self.has_healing_move?(battle, battler)
      memory = get_memory(battle, battler)
      !memory[:healing_moves].nil? && memory[:healing_moves].any?
    end
    
    # Prüft ob Battler Setup Moves hat
    def self.has_setup_move?(battle, battler)
      memory = get_memory(battle, battler)
      !memory[:setup_moves].nil? && memory[:setup_moves].any?
    end
    
    # Holt stärksten bekannten Move
    def self.strongest_known_move(battle, battler)
      memory = get_memory(battle, battler)
      return nil if memory[:moves].nil? || memory[:moves].empty?
      
      memory[:moves].max_by do |move_id|
        GameData::Move.get(move_id).base_damage
      end
    end
    
    # Schätzt maximalen Schaden
    def self.max_known_damage(battle, attacker, defender)
      return 0 unless attacker && defender
      memory = get_memory(battle, attacker)
      return 0 if memory[:moves].nil? || memory[:moves].empty?
      
      max_damage = 0
      
      memory[:moves].each do |move_id|
        move_data = GameData::Move.get(move_id)
        next unless move_data.damagingMove?
        
        # Vereinfachte Schadens-Berechnung
        bp = move_data.base_damage
        type_mod = Effectiveness.calculate(move_data.type, defender.types[0], defender.types[1])
        stab = attacker.pbHasType?(move_data.type) ? 1.5 : 1.0
        
        atk = move_data.physicalMove? ? attacker.attack : attacker.spatk
        defense = move_data.physicalMove? ? defender.defense : defender.spdef
        
        damage = ((2 * attacker.level / 5.0 + 2) * bp * atk / defense / 50 + 2)
        damage *= type_mod * stab
        
        max_damage = [max_damage, damage.to_i].max
      end
      
      max_damage
    end
    
    # Holt letzten Move
    def self.last_move(battle, battler)
      memory = get_memory(battle, battler)
      memory[:last_move]
    end
    
    # Holt Move-Häufigkeit
    def self.move_frequency(battle, battler, move_id)
      memory = get_memory(battle, battler)
      memory[:move_counts]&.[](move_id) || 0
    end
    
    # Cleanup nach Battle
    def self.cleanup_battle(battle)
      @battle_memory.delete(battle.object_id) if battle
    end
  end
end

# Integration in Battle
class Battle
  alias aai_memory_pbEndOfBattle pbEndOfBattle
  def pbEndOfBattle
    AdvancedAI::MoveMemory.cleanup_battle(self)
    aai_memory_pbEndOfBattle
  end
end

# Integration in Move Usage
class Battle::Battler
  alias aai_memory_pbUseMoveSimple pbUseMoveSimple
  def pbUseMoveSimple(move_id, target = -1, idx = -1, specialUsage = false)
    # Speichere Move bevor er genutzt wird
    if @battle.pbOwnedByPlayer?(@index)
      AdvancedAI::MoveMemory.remember_move(@battle, self, @moves[idx]) if @moves[idx]
    end
    
    aai_memory_pbUseMoveSimple(move_id, target, idx, specialUsage)
  end
end

# API-Wrapper für einfachen Zugriff
module AdvancedAI
  def self.get_memory(battle, battler)
    MoveMemory.get_memory(battle, battler)
  end
  
  def self.knows_move?(battle, battler, move_id)
    MoveMemory.knows_move?(battle, battler, move_id)
  end
  
  def self.has_priority_move?(battle, battler)
    MoveMemory.has_priority_move?(battle, battler)
  end
  
  def self.has_healing_move?(battle, battler)
    MoveMemory.has_healing_move?(battle, battler)
  end
  
  def self.has_setup_move?(battle, battler)
    MoveMemory.has_setup_move?(battle, battler)
  end
  
  def self.strongest_known_move(battle, battler)
    MoveMemory.strongest_known_move(battle, battler)
  end
  
  def self.max_known_damage(battle, attacker, defender)
    MoveMemory.max_known_damage(battle, attacker, defender)
  end
  
  def self.last_move(battle, battler)
    MoveMemory.last_move(battle, battler)
  end
  
  def self.move_frequency(battle, battler, move_id)
    MoveMemory.move_frequency(battle, battler, move_id)
  end
end

AdvancedAI.log("Move Memory System loaded (Reborn-inspired)", "Memory")
