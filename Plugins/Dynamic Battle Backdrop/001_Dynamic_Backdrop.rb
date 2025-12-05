#===============================================================================
# Custom Battle Backdrop Message
#===============================================================================
# This plugin allows you to dynamically change the battle backdrop 
# (including the message box) based on specific conditions.
#===============================================================================

module BattleCreationHelperMethods
  module_function
  
  # Store the original method
  class << self
    alias custom_backdrop_prepare_battle prepare_battle
  end
  
  def prepare_battle(battle)
    # Call the original method
    custom_backdrop_prepare_battle(battle)
    
    # ============================================================================
    # ADD YOUR CUSTOM BACKDROP CHANGES HERE
    # ============================================================================
    
    # Example 1: Change backdrop based on a Game Switch
    if $game_switches[990]  # Change the number to your preference
      battle.backdrop = "cave"
      battle.backdropBase = "rocky"
    end
    
    # Example 2: Change backdrop based on Map ID
    if $game_map.map_id == 10  # Map ID 10
      battle.backdrop = "forest"
      battle.backdropBase = "grass"
    end
    
    # Example 3: Change backdrop based on Game Variable
    map_backdrop = $game_variables[100]  # Variable 100
    if map_backdrop && map_backdrop != "" && map_backdrop.is_a?(String)
      battle.backdrop = map_backdrop.to_s
      # Optional: Reset the variable after use
      # $game_variables[100] = nil
    end
    
    # Example 4: Change backdrop based on time of day
    # if battle.time == 2  # Night
    #   battle.backdrop = "night_special"
    # end
    
    # ============================================================================
    # END OF CUSTOMIZATIONS
    # ============================================================================
  end
end
