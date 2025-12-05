#===============================================================================
# Common Event Templates
# Vorgefertigte Templates für häufig genutzte Events
#===============================================================================

#===============================================================================
# Item Ball Template
#===============================================================================
event_template :item_ball do |item:, quantity: 1, hidden: false|
  if_has_item(item, quantity) do
    message("The Poké Ball is empty...")
  end.else do
    play_me("Item get")
    message("\\me[Item get]#{$player.name} found #{GameData::Item.get(item).portion_name}!\\wtnp[30]")
    give_item(item, quantity)
    set_switch($game_map.events[@event_id]&.id || 1, true) # Deaktiviere Event
  end
end

#===============================================================================
# Hidden Item Template
#===============================================================================
event_template :hidden_item do |item:, quantity: 1|
  if_has_item(item, quantity) do
    # Nichts - Itemfinder schlägt nicht an wenn schon gefunden
  end.else do
    play_me("Item get")
    message("#{$player.name} found one #{GameData::Item.get(item).portion_name}!\\wtnp[30]")
    give_item(item, quantity)
    set_switch($game_map.events[@event_id]&.id || 1, true)
  end
end

#===============================================================================
# Nurse Joy Template (Pokémon Center Healing)
#===============================================================================
event_template :nurse_joy do |greeting: "Welcome to our Pokémon Center!", farewell: "We hope to see you again!"|
  message(greeting)
  message("Would you like me to heal your Pokémon?")
  choices(["Yes, please", "No, thanks"]) do |choice|
    if choice == 0
      message("Okay, I'll take your Pokémon for a few seconds.")
      fade_screen
      play_se("Recovery")
      heal_party
      wait(40)
      message("Your Pokémon are fully healed!")
      message(farewell)
    else
      message(farewell)
    end
  end
end

#===============================================================================
# Simple Trainer Battle Template
#===============================================================================
event_template :trainer_battle do |trainer_type:, trainer_name:, version: 0, 
                                    intro: nil, lose_text: nil, after_text: nil, 
                                    switch: nil, can_lose: false|
  
  # Prüfe ob schon besiegt (über Switch)
  if switch
    if_switch(switch) do
      message(after_text) if after_text
    end.else do
      message(intro) if intro
      battle_trainer(trainer_type, trainer_name, version)
      set_switch(switch, true)
      message(after_text) if after_text
    end
  else
    message(intro) if intro
    battle_trainer(trainer_type, trainer_name, version)
    message(after_text) if after_text
  end
end

#===============================================================================
# Gift Pokemon Template
#===============================================================================
event_template :gift_pokemon do |species:, level:, nickname: nil, item: nil, 
                                 shiny: false, gender: nil, nature: nil, moves: nil,
                                 text_before: "I'd like you to have this Pokémon!",
                                 text_after: "Take good care of it!"|
  message(text_before)
  
  options = {}
  options[:item] = item if item
  options[:shiny] = shiny if shiny
  options[:gender] = gender if gender
  options[:nature] = nature if nature
  options[:moves] = moves if moves
  
  give_pokemon(species, level, **options)
  message(text_after)
end

#===============================================================================
# PC & Healing Template (für Zuhause)
#===============================================================================
event_template :pc_and_heal do
  message("Your own PC! You can store Pokémon here.")
  choices(["Access PC", "Heal Party", "Cancel"]) do |choice|
    case choice
    when 0
      open_pc
    when 1
      message("Healing your Pokémon...")
      heal_party
      message("Your Pokémon are fully healed!")
    end
  end
end

#===============================================================================
# Shop Template
#===============================================================================
event_template :shop do |items:, greeting: "Welcome! How may I help you?", farewell: "Please come again!"|
  message(greeting)
  open_mart(items)
  message(farewell)
end

#===============================================================================
# Berry Tree Template
#===============================================================================
event_template :berry_tree do |berry:, quantity: 2|
  message("It's a Berry plant!")
  if_switch($game_map.events[@event_id]&.id || 1) do
    message("The plant is growing new berries...")
  end.else do
    message("Picked #{quantity} #{GameData::Item.get(berry).portion_name}!")
    give_item(berry, quantity)
    set_switch($game_map.events[@event_id]&.id || 1, true)
  end
end

#===============================================================================
# Cut Tree Template
#===============================================================================
event_template :cut_tree do
  if_has_badge(1) do # Badge 1 = Cut erlaubt
    message("This tree looks like it can be cut!")
    choices(["Cut it down", "Leave it"]) do |choice|
      if choice == 0
        play_se("Battle damage")
        message("The tree was cut down!")
        set_switch($game_map.events[@event_id]&.id || 1, true) # Entferne Baum
      end
    end
  end.else do
    message("It's a small tree. Maybe it can be cut down?")
  end
end

#===============================================================================
# Rock Smash Template
#===============================================================================
event_template :smash_rock do |item: nil, pokemon_species: nil, pokemon_level: 5|
  if_has_badge(3) do # Badge 3 = Rock Smash erlaubt
    message("This rock appears to be breakable!")
    choices(["Smash it", "Leave it"]) do |choice|
      if choice == 0
        play_se("Battle damage")
        message("The rock was smashed!")
        
        if item
          message("There was something inside!")
          give_item(item, 1)
        elsif pokemon_species
          message("A wild Pokémon appeared!")
          battle_wild(pokemon_species, pokemon_level)
        end
        
        set_switch($game_map.events[@event_id]&.id || 1, true)
      end
    end
  end.else do
    message("It's a cracked rock. Maybe it can be smashed?")
  end
end

#===============================================================================
# Roaming Legendary Template
#===============================================================================
event_template :release_roaming do |species:, level:, text: "A legendary Pokémon fled!"|
  message(text)
  play_se("Battle flee")
  create_roaming(species, level)
  set_switch($game_map.events[@event_id]&.id || 1, true)
end

#===============================================================================
# Evolution Stone Template
#===============================================================================
event_template :evolution_stone do |species:, stone:, text_before: "Use the #{stone} on which Pokémon?",
                                    text_after: "Come back if you change your mind!"|
  if_has_pokemon(species) do
    message(text_before)
    # Hier würde Pokémon-Auswahl kommen - vereinfacht:
    evolve_pokemon(species)
  end.else do
    message(text_after)
  end
end

#===============================================================================
# Sign/Notice Board Template
#===============================================================================
event_template :sign do |text:|
  message(text)
end

#===============================================================================
# Rival Battle Template (mit Story-Fortschritt)
#===============================================================================
event_template :rival_battle do |trainer_type:, trainer_name:, version: 0,
                                 intro:, defeat_text:, after_battle_text:,
                                 story_switch:|
  
  if_switch(story_switch) do
    message(after_battle_text)
  end.else do
    message(intro)
    battle_trainer(trainer_type, trainer_name, version)
    message(defeat_text)
    give_money(2000) # Rival gibt manchmal Geld/Items
    message(after_battle_text)
    set_switch(story_switch, true)
  end
end

#===============================================================================
# Gym Leader Battle Template
#===============================================================================
event_template :gym_leader do |trainer_type:, trainer_name:, badge_id:, badge_name:,
                               tm_item:, prize_money: 5000,
                               intro: "Let's begin our battle!",
                               defeat_text: "You were too strong!",
                               badge_text: "You've earned the #{badge_name}!"|
  
  if_has_badge(badge_id) do
    message("You've already defeated me. Keep training!")
  end.else do
    message(intro)
    battle_trainer(trainer_type, trainer_name, 0)
    
    # Nach Sieg
    message(defeat_text)
    play_me("Jingle - Badge")
    message(badge_text)
    give_money(prize_money)
    message("Here, take this TM as well!")
    give_item(tm_item, 1)
    
    # Badge geben (muss separat implementiert werden)
    script("$player.badges[#{badge_id}] = true")
  end
end

#===============================================================================
# Weather Changer Template
#===============================================================================
event_template :weather_changer do |weather: :Rain, duration: 0|
  message("The weather is changing!")
  change_weather(weather, duration)
end

#===============================================================================
# Legendary Encounter Template (mit Catch-Check)
#===============================================================================
event_template :legendary_encounter do |species:, level:, text_before: "A powerful presence...",
                                        text_caught: "You caught the legendary Pokémon!",
                                        text_defeat: "The Pokémon fled!"|
  
  if_has_pokemon(species) do
    message("Nothing here...")
  end.else do
    message(text_before)
    play_se("Battle recall")
    battle_wild(species, level)
    
    # Prüfe ob gefangen (vereinfacht)
    if_has_pokemon(species) do
      message(text_caught)
    end.else do
      message(text_defeat)
    end
    
    set_switch($game_map.events[@event_id]&.id || 1, true)
  end
end

#===============================================================================
# Multi-Choice Door Template
#===============================================================================
event_template :locked_door do |key_item:, text_locked: "The door is locked.",
                                text_unlocked: "The door is now unlocked!",
                                target_map:, target_x:, target_y:|
  
  if_has_item(key_item) do
    message(text_unlocked)
    transfer_player(target_map, target_x, target_y)
  end.else do
    message(text_locked)
  end
end

#===============================================================================
# Tutorial NPC Template
#===============================================================================
event_template :tutorial_npc do |tutorial_text:, completion_switch:|
  if_switch(completion_switch) do
    message("Good luck on your journey!")
  end.else do
    message(tutorial_text)
    set_switch(completion_switch, true)
  end
end
