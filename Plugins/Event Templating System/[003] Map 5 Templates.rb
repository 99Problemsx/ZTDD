#===============================================================================
# Map 5 Events - Route 1
# Alle Events für Route 1 als Templates definiert
#===============================================================================

#===============================================================================
# Item Balls auf Route 1
#===============================================================================

# Event ID 1: Potion im Gras
event_template :route1_potion do
  use_template(:item_ball, item: :POTION, quantity: 1)
end

# Event ID 2: Pokéball bei den Bäumen
event_template :route1_pokeball do
  use_template(:item_ball, item: :POKEBALL, quantity: 1)
end

# Event ID 3: Versteckter Antidote
event_template :route1_hidden_antidote do
  use_template(:hidden_item, item: :ANTIDOTE)
end

#===============================================================================
# Trainer auf Route 1
#===============================================================================

# Event ID 10: Youngster Joey
event_template :route1_youngster_joey do
  use_template(:trainer_battle,
    trainer_type: :YOUNGSTER,
    trainer_name: "Joey",
    intro: "My Rattata is in the top percentage of Rattata!",
    after_text: "My Rattata is still the best!",
    switch: 100  # Switch 100 = Joey defeated
  )
end

# Event ID 11: Bug Catcher Don
event_template :route1_bug_catcher_don do
  use_template(:trainer_battle,
    trainer_type: :BUGCATCHER,
    trainer_name: "Don",
    intro: "I've been training my bug Pokémon!",
    after_text: "Bugs are still cool though!",
    switch: 101
  )
end

# Event ID 12: Lass Amy
event_template :route1_lass_amy do
  use_template(:trainer_battle,
    trainer_type: :LASS,
    trainer_name: "Amy",
    intro: "Let's have a cute Pokémon battle!",
    after_text: "Your Pokémon are so strong!",
    switch: 102
  )
end

#===============================================================================
# NPCs
#===============================================================================

# Event ID 20: Professor's Assistant (gibt Running Shoes)
event_template :route1_running_shoes_guy do
  if_switch(110) do
    message("Running Shoes let you move faster! Try holding the run button!")
  end.else do
    message("Hey! The Professor sent me to give you these!")
    play_me("Item get")
    message("\\me[Item get]You got the Running Shoes!\\wtnp[30]")
    script("$PokemonGlobal.runningShoes = true")
    message("Hold the run button to move faster!")
    set_switch(110, true)
  end
end

# Event ID 21: Youngster Teaching About Status
event_template :route1_status_teacher do
  message("Did you know? Status conditions like Paralysis and Burn affect battles!")
  message("You can cure them with items from the Poké Mart!")
end

# Event ID 22: Berry Lady (gibt daily Berry)
event_template :route1_berry_lady do
  if_switch(111) do
    message("Come back tomorrow for another berry!")
  end.else do
    message("Hello! Would you like a berry for your journey?")
    choices(["Yes, please!", "No thanks"]) do |choice|
      if choice == 0
        give_item(:ORANBERRY, 1)
        message("Here you go! Berries can heal your Pokémon!")
        set_switch(111, true)
      end
    end
  end
end

#===============================================================================
# Environmental Events
#===============================================================================

# Event ID 30: Cut Tree blocking path
event_template :route1_cut_tree do
  use_template(:cut_tree)
end

# Event ID 31: Breakable Rock
event_template :route1_rock_smash do
  use_template(:smash_rock, item: :STARDUST)
end

# Event ID 32: Berry Tree
event_template :route1_berry_tree do
  use_template(:berry_tree, berry: :PECHABERRY, quantity: 2)
end

#===============================================================================
# Signs
#===============================================================================

# Event ID 40: Route Sign
event_template :route1_sign do
  use_template(:sign, text: "ROUTE 1\\nPALLET TOWN - VIRIDIAN CITY")
end

# Event ID 41: Warning Sign
event_template :route1_warning do
  use_template(:sign, text: "TALL GRASS!\\nWild Pokémon may appear!\\nKeep your own Pokémon with you for protection!")
end

#===============================================================================
# Special Events
#===============================================================================

# Event ID 50: Rival Encounter
event_template :route1_rival_encounter do
  if_switch(120) do
    message("Your rival: Smell ya later!")
  end.else do
    message("Your rival: #{$player.name}! Let's battle!")
    
    # Rival battle (Starter based on player's choice)
    if $player.first_pokemon_species == :BULBASAUR
      battle_trainer(:RIVAL1, $rival_name, 0)  # Rival hat Charmander
    elsif $player.first_pokemon_species == :CHARMANDER
      battle_trainer(:RIVAL1, $rival_name, 1)  # Rival hat Squirtle
    else
      battle_trainer(:RIVAL1, $rival_name, 2)  # Rival hat Bulbasaur
    end
    
    message("Your rival: You got lucky this time!")
    set_switch(120, true)
  end
end

# Event ID 51: Mystery Egg Event
event_template :route1_mystery_egg do
  if_switch(121) do
    message("The nest is empty now.")
  end.else do
    message("You found an egg in a nest!")
    choices(["Take the egg?", "Leave it"]) do |choice|
      if choice == 0
        message("You carefully took the egg.")
        give_pokemon(:TOGEPI, 1)  # Ei als Level 1 Pokemon
        message("The egg was added to your party!")
        set_switch(121, true)
      else
        message("You left the egg alone.")
      end
    end
  end
end

#===============================================================================
# Optional: Weather Event
#===============================================================================

# Event ID 60: Rain Weather Trigger
event_template :route1_start_rain do
  if_switch(130) do
    # Rain already triggered
  end.else do
    message("Dark clouds are gathering...")
    wait(20)
    change_weather(:Rain, 0)  # 0 = infinite duration
    message("It started raining!")
    set_switch(130, true)
  end
end

#===============================================================================
# HOW TO USE IN RMXP:
#===============================================================================
# 1. Erstelle Event auf Map 5 (Route 1)
# 2. Füge "Script" command hinzu
# 3. Schreibe: EventTemplates.execute(:route1_potion)
# 4. Fertig!
#
# Oder direkt mit Custom-Parametern:
# EventTemplates.execute(:item_ball, item: :SUPERPOTION, quantity: 3)
#===============================================================================
