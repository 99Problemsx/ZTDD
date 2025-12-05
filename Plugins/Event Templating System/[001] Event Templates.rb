#===============================================================================
# Event Templating System
# Define reusable event templates in Ruby instead of copying events in RMXP
# Based on Luka S.J.'s approach
#===============================================================================

module EventTemplates
  @templates = {}
  
  # Register a new event template
  def self.register(name, &block)
    @templates[name] = block
  end
  
  # Get a template by name
  def self.get(name)
    @templates[name]
  end
  
  # Check if template exists
  def self.exists?(name)
    @templates.key?(name)
  end
  
  # List all templates
  def self.all
    @templates.keys
  end
  
  #=============================================================================
  # Event Builder - DSL for creating events
  #=============================================================================
  class EventBuilder
    attr_reader :commands
    
    def initialize
      @commands = []
    end
    
    # Text message
    def message(text)
      @commands << [:message, text]
    end
    
    # Show choices
    def choices(options, &block)
      @commands << [:choices, options, block]
    end
    
    # Conditional branch
    def if_switch(switch_id, &block)
      branch = EventBuilder.new
      branch.instance_eval(&block)
      @commands << [:if_switch, switch_id, branch.commands]
    end
    
    # Set switch
    def set_switch(switch_id, value = true)
      @commands << [:set_switch, switch_id, value]
    end
    
    # Set variable
    def set_variable(var_id, value)
      @commands << [:set_variable, var_id, value]
    end
    
    # Give item
    def give_item(item, quantity = 1)
      @commands << [:give_item, item, quantity]
    end
    
    # Give Pokemon (advanced)
    def give_pokemon(species, level, **options)
      @commands << [:give_pokemon, species, level, options]
    end
    
    # Start battle
    def battle_wild(species, level)
      @commands << [:battle_wild, species, level]
    end
    
    # Start trainer battle
    def battle_trainer(trainer_type, trainer_name, version = 0)
      @commands << [:battle_trainer, trainer_type, trainer_name, version]
    end
    
    # Play SE (sound effect)
    def play_se(filename, volume = 100, pitch = 100)
      @commands << [:play_se, filename, volume, pitch]
    end
    
    # Play ME (music effect)
    def play_me(filename, volume = 100, pitch = 100)
      @commands << [:play_me, filename, volume, pitch]
    end
    
    # Change BGM
    def play_bgm(filename, volume = 100, pitch = 100)
      @commands << [:play_bgm, filename, volume, pitch]
    end
    
    # Fade screen
    def fade_screen
      @commands << [:fade_screen]
    end
    
    # Show animation
    def show_animation(animation_id, target = 0)
      @commands << [:show_animation, animation_id, target]
    end
    
    # Move event
    def move_event(event_id, direction, speed = 3)
      @commands << [:move_event, event_id, direction, speed]
    end
    
    # Wait
    def wait(frames)
      @commands << [:wait, frames]
    end
    
    # Transfer player
    def transfer_player(map_id, x, y, direction = 2)
      @commands << [:transfer_player, map_id, x, y, direction]
    end
    
    # Execute script
    def script(code)
      @commands << [:script, code]
    end
    
    # Common event
    def call_common_event(event_id)
      @commands << [:common_event, event_id]
    end
    
    # Execute template
    def use_template(template_name, **params)
      @commands << [:template, template_name, params]
    end
    
    # Checkbox/Options conditional
    def if_value(expression, &block)
      branch = EventBuilder.new
      branch.instance_eval(&block) if block_given?
      @commands << [:if_value, expression, branch.commands]
    end
    
    # Else branch
    def else(&block)
      branch = EventBuilder.new
      branch.instance_eval(&block) if block_given?
      @commands << [:else, branch.commands]
    end
    
    # Check if player has item
    def if_has_item(item, quantity = 1, &block)
      branch = EventBuilder.new
      branch.instance_eval(&block) if block_given?
      @commands << [:if_has_item, item, quantity, branch.commands]
    end
    
    # Check if player has Pokemon
    def if_has_pokemon(species, &block)
      branch = EventBuilder.new
      branch.instance_eval(&block) if block_given?
      @commands << [:if_has_pokemon, species, branch.commands]
    end
    
    # Check if badge
    def if_has_badge(badge_id, &block)
      branch = EventBuilder.new
      branch.instance_eval(&block) if block_given?
      @commands << [:if_has_badge, badge_id, branch.commands]
    end
    
    # Give/remove money
    def give_money(amount)
      @commands << [:give_money, amount]
    end
    
    # Heal party
    def heal_party
      @commands << [:heal_party]
    end
    
    # PC access
    def open_pc
      @commands << [:open_pc]
    end
    
    # Mart access
    def open_mart(items)
      @commands << [:open_mart, items]
    end
    
    # Pokemon storage
    def send_to_storage(species, level, **options)
      @commands << [:send_to_storage, species, level, options]
    end
    
    # Show picture
    def show_picture(pic_id, name, x, y)
      @commands << [:show_picture, pic_id, name, x, y]
    end
    
    # Erase picture
    def erase_picture(pic_id)
      @commands << [:erase_picture, pic_id]
    end
    
    # Change weather
    def change_weather(weather_type, duration = 0)
      @commands << [:change_weather, weather_type, duration]
    end
    
    # Battle wild (advanced with options)
    def battle_wild_ex(species, level, **options)
      @commands << [:battle_wild_ex, species, level, options]
    end
    
    # Roaming Pokemon
    def create_roaming(species, level, **options)
      @commands << [:create_roaming, species, level, options]
    end
    
    # Enable/disable following Pokemon
    def toggle_follower(enabled = true)
      @commands << [:toggle_follower, enabled]
    end
    
    # Evolve Pokemon in party
    def evolve_pokemon(species)
      @commands << [:evolve_pokemon, species]
    end
    
    # Day care interactions
    def daycare_deposit
      @commands << [:daycare_deposit]
    end
    
    def daycare_withdraw
      @commands << [:daycare_withdraw]
    end
  end
end

#===============================================================================
# Helper method to define templates
#===============================================================================

def event_template(name, &block)
  EventTemplates.register(name, &block)
end

#===============================================================================
# Execute template commands
#===============================================================================

module EventTemplates
  def self.execute(template_name, event = nil, **params)
    template = get(template_name)
    return false unless template
    
    builder = EventBuilder.new
    builder.instance_eval(&template)
    
    # Execute all commands
    builder.commands.each do |cmd|
      execute_command(cmd, event, params)
    end
    
    true
  end
  
  def self.execute_command(cmd, event, params)
    command_type = cmd[0]
    
    case command_type
    when :message
      pbMessage(cmd[1])
    when :choices
      options_array = cmd[1]
      block = cmd[2]
      choice = pbMessage("", options_array, -1)
      block.call(choice) if block
    when :give_item
      pbReceiveItem(cmd[1], cmd[2])
    when :give_pokemon
      pkmn = Pokemon.new(cmd[1], cmd[2])
      options = cmd[3] || {}
      pkmn.item = options[:item] if options[:item]
      pkmn.shiny = true if options[:shiny]
      pkmn.gender = options[:gender] if options[:gender]
      pkmn.form = options[:form] if options[:form]
      pkmn.ability_index = options[:ability_index] if options[:ability_index]
      pkmn.nature = options[:nature] if options[:nature]
      options[:moves]&.each_with_index { |move, i| pkmn.learn_move(move) if i < 4 }
      pbAddPokemon(pkmn)
    when :battle_wild
      pbWildBattle(cmd[1], cmd[2])
    when :battle_wild_ex
      species, level, options = cmd[1], cmd[2], cmd[3] || {}
      pkmn = Pokemon.new(species, level)
      pkmn.item = options[:item] if options[:item]
      pkmn.shiny = true if options[:shiny]
      pkmn.gender = options[:gender] if options[:gender]
      pkmn.form = options[:form] if options[:form]
      pkmn.ability_index = options[:ability_index] if options[:ability_index]
      options[:moves]&.each_with_index { |move, i| pkmn.learn_move(move) if i < 4 }
      pbWildBattle(pkmn)
    when :battle_trainer
      pbTrainerBattle(cmd[1], cmd[2], nil, false, cmd[3])
    when :play_se
      pbSEPlay(cmd[1], cmd[2], cmd[3])
    when :play_me
      pbMEPlay(cmd[1], cmd[2], cmd[3])
    when :play_bgm
      pbBGMPlay(cmd[1], cmd[2], cmd[3])
    when :set_switch
      $game_switches[cmd[1]] = cmd[2]
    when :set_variable
      $game_variables[cmd[1]] = cmd[2]
    when :wait
      pbWait(cmd[1])
    when :transfer_player
      pbFadeOutIn { 
        $game_temp.player_new_map_id = cmd[1]
        $game_temp.player_new_x = cmd[2]
        $game_temp.player_new_y = cmd[3]
        $game_temp.player_new_direction = cmd[4]
        $scene.transfer_player 
      }
    when :script
      eval(cmd[1])
    when :template
      execute(cmd[1], event, cmd[2])
    when :if_has_item
      if $bag.has?(cmd[1], cmd[2])
        cmd[3].each { |sub_cmd| execute_command(sub_cmd, event, params) }
      end
    when :if_has_pokemon
      if $player.has_species?(cmd[1])
        cmd[2].each { |sub_cmd| execute_command(sub_cmd, event, params) }
      end
    when :if_has_badge
      if $player.badge_count >= cmd[1] || $player.badges[cmd[1]]
        cmd[2].each { |sub_cmd| execute_command(sub_cmd, event, params) }
      end
    when :give_money
      $player.money += cmd[1]
    when :heal_party
      pbFullHeal
    when :open_pc
      pbPokeCenterPC
    when :open_mart
      pbPokemonMart(cmd[1])
    when :send_to_storage
      pkmn = Pokemon.new(cmd[1], cmd[2])
      options = cmd[3] || {}
      pkmn.item = options[:item] if options[:item]
      pkmn.shiny = true if options[:shiny]
      $PokemonStorage.pbStoreCaught(pkmn)
    when :show_picture
      $game_screen.pictures[cmd[1]].show(cmd[2], 0, cmd[3], cmd[4], 100, 100, 255, 0)
    when :erase_picture
      $game_screen.pictures[cmd[1]].erase
    when :change_weather
      $game_screen.weather(cmd[1], cmd[2], 20)
    when :create_roaming
      species, level, options = cmd[1], cmd[2], cmd[3] || {}
      pkmn = Pokemon.new(species, level)
      pkmn.item = options[:item] if options[:item]
      pkmn.shiny = true if options[:shiny]
      pbCreateRoamer(pkmn)
    when :toggle_follower
      $PokemonGlobal.follower_toggled = cmd[1]
    when :evolve_pokemon
      pbEvolutionCheck($player.party) if $player.has_species?(cmd[1])
    when :daycare_deposit
      pbDayCareDeposit
    when :daycare_withdraw
      pbDayCareWithdraw
    end
  end
end
