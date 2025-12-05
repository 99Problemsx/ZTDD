#===============================================================================
# MapTrainer System for Event Importer
# Handles trainer battle management
#===============================================================================

module GameData
  class MapTrainer
    @@trainers = {}
    
    class << self
      # Register a trainer (called by Event Importer)
      def register_from_import(map_id, event_id, trainer_type, trainer_name, party, items = [], lose_text = nil, intro_text = nil)
        key = [map_id, event_id]
        
        trainer_data = {
          :map_id => map_id,
          :event_id => event_id,
          :trainer_type => trainer_type,
          :trainer_name => trainer_name,
          :lose_text => lose_text || "...",
          :intro_text => intro_text,
          :party => party,
          :items => items || []
        }
        
        @@trainers[key] = trainer_data
        echoln("✓ Registered MapTrainer: Map #{map_id}, Event #{event_id} - #{trainer_type} #{trainer_name} (#{party.length} Pokemon)")
      end
      
      # Called by event script: GameData::MapTrainer.notice(self)
      def notice(interpreter)
        map_id = $game_map.map_id
        event_id = interpreter.instance_variable_get(:@event_id)
        
        # Check if trainer has already been defeated (self switch A is true)
        if $game_self_switches[[map_id, event_id, "A"]]
          echoln("MapTrainer.notice: Trainer already defeated (Map #{map_id}, Event #{event_id})")
          return false
        end
        
        key = [map_id, event_id]
        trainer_data = @@trainers[key]
        
        if trainer_data
          echoln("MapTrainer.notice: Found trainer on Map #{map_id}, Event #{event_id}")
          outcome = start_battle(trainer_data, event_id, interpreter)
          
          if outcome == true
            interpreter.pbSetSelfSwitch(event_id, "A", true)
            echoln("MapTrainer.notice: Trainer defeated, self switch A set to true")
          end
          return outcome
        else
          echoln("MapTrainer.notice: No trainer found for Map #{map_id}, Event #{event_id}")
          return false
        end
      end
      
      # Start trainer battle
      def start_battle(trainer_data, event_id, interpreter)
        trainer_type = trainer_data[:trainer_type]
        trainer_name = trainer_data[:trainer_name]
        lose_text = trainer_data[:lose_text] || "..."
        intro_text = trainer_data[:intro_text]
        
        echoln("Starting battle: #{trainer_type} #{trainer_name}")
        
        # Show intro text if exists
        pbMessage(intro_text) if intro_text
        
        # Create NPCTrainer object
        trainer = NPCTrainer.new(trainer_name, trainer_type)
        trainer.lose_text = lose_text
        trainer.items = trainer_data[:items] || []
        trainer.party = []  # Clear any existing party
        
        # Build party from data
        echoln("Party size: #{trainer_data[:party].length}")
        trainer_data[:party].each do |pkmn_data|
          echoln("Creating Pokemon: #{pkmn_data[:species]} Lv.#{pkmn_data[:level]}")
          pkmn = Pokemon.new(pkmn_data[:species], pkmn_data[:level])
          pkmn.ability = pkmn_data[:ability] if pkmn_data[:ability]
          pkmn.item = pkmn_data[:item] if pkmn_data[:item]
          pkmn.gender = pkmn_data[:gender] unless pkmn_data[:gender].nil?
          
          if pkmn_data[:moves] && pkmn_data[:moves].any?
            pkmn_data[:moves].each_with_index do |move, i|
              break if i >= 4
              pkmn.moves[i] = Pokemon::Move.new(move) if GameData::Move.exists?(move)
            end
          else
            pkmn.reset_moves
          end
          
          pkmn.calc_stats
          trainer.party << pkmn
        end
        
        echoln("Trainer party built: #{trainer.party.length} Pokemon")
        echoln("Calling TrainerBattle.start...")
        
        # Start battle using Essentials' TrainerBattle.start
        result = TrainerBattle.start(trainer)
        
        echoln("Battle ended with result: #{result}")
        return result
      end
      
      # Get all trainers (for debug)
      def all
        return @@trainers
      end
      
      # Clear all trainers (for reimport)
      def clear
        @@trainers.clear
      end
    end
  end
end

echoln(">>> MapTrainer System loaded - use MAPTRAINER in event files!")


