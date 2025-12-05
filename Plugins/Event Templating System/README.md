# Event Templating System

Ein Template-System für Events wie von Luka - definiere Events in Ruby statt im RMXP Editor!

## Warum?

- **Kein RMXP Editor nötig**: Alles in Ruby Code
- **Wiederverwendbar**: Einmal definieren, überall nutzen
- **Übersichtlich**: Code ist lesbarer als Event-Commands
- **Versionskontrolliert**: Git kann Events tracken
- **Schnell**: Copy-Paste statt mühsames Event-Klicken

## Installation

Das Plugin ist bereits aktiv. Einfach Templates definieren und nutzen!

## Grundlegendes

### Template definieren

```ruby
event_template :mein_template do |param1:, param2: "default"|
  message("Hallo #{param1}!")
  give_item(param2, 1)
end
```

### Template benutzen

**In einem Event (Script-Command):**

```ruby
EventTemplates.execute(:mein_template, param1: "Welt", param2: :POTION)
```

**In anderem Template:**

```ruby
event_template :wrapper do
  use_template(:mein_template, param1: "Nested", param2: :POKEBALL)
end
```

## Verfügbare Befehle

### Nachrichten & Text

- `message(text)` - Zeige Textbox
- `choices(["Option 1", "Option 2"])` - Zeige Auswahlmenü
- `sign(text:)` - Template für Schilder

### Items & Geld

- `give_item(item, quantity)` - Gebe Item
- `give_money(amount)` - Gebe/nehme Geld
- `open_mart(items)` - Öffne Shop
- `shop(items:, greeting:, farewell:)` - Shop-Template

### Pokémon

- `give_pokemon(species, level, **options)` - Gebe Pokémon
  - Optionen: `:item`, `:shiny`, `:gender`, `:form`, `:nature`, `:moves`
- `heal_party()` - Heile Team
- `battle_wild(species, level)` - Wild-Kampf
- `battle_wild_ex(species, level, **options)` - Wild-Kampf mit Optionen
- `battle_trainer(type, name, version)` - Trainer-Kampf
- `evolve_pokemon(species)` - Evolution auslösen
- `send_to_storage(species, level, **options)` - Direkt zu Box
- `create_roaming(species, level, **options)` - Roaming Pokemon

### Conditionals (Bedingungen)

- `if_switch(switch_id) { ... }` - Prüfe Switch
- `if_has_item(item, quantity) { ... }` - Prüfe Item
- `if_has_pokemon(species) { ... }` - Prüfe Pokémon im Team
- `if_has_badge(badge_id) { ... }` - Prüfe Badge
- `if_value(expression) { ... }` - Prüfe beliebigen Wert

### Switches & Variables

- `set_switch(switch_id, value)` - Setze Switch
- `set_variable(var_id, value)` - Setze Variable

### Audio

- `play_se(filename, volume, pitch)` - Sound Effect
- `play_me(filename, volume, pitch)` - Music Effect
- `play_bgm(filename, volume, pitch)` - Background Music

### Effekte & Visuals

- `fade_screen()` - Fade out/in
- `show_picture(id, name, x, y)` - Zeige Bild
- `erase_picture(id)` - Entferne Bild
- `show_animation(anim_id, target)` - Spiele Animation
- `change_weather(type, duration)` - Ändere Wetter

### Movement & Transfer

- `transfer_player(map_id, x, y, direction)` - Teleportiere Spieler
- `move_event(event_id, direction, speed)` - Bewege Event
- `wait(frames)` - Warte

### Sonstiges

- `open_pc()` - Öffne PC
- `script(code)` - Führe Ruby-Code aus
- `call_common_event(event_id)` - Rufe Common Event auf

## Vorgefertigte Templates

### Item Ball

```ruby
EventTemplates.execute(:item_ball, item: :POTION, quantity: 1)
```

### Hidden Item

```ruby
EventTemplates.execute(:hidden_item, item: :RARECANDY)
```

### Nurse Joy (Pokémon Center)

```ruby
EventTemplates.execute(:nurse_joy)
# Oder mit custom Text:
EventTemplates.execute(:nurse_joy,
  greeting: "Willkommen!",
  farewell: "Bis bald!"
)
```

### Trainer Battle

```ruby
EventTemplates.execute(:trainer_battle,
  trainer_type: :YOUNGSTER,
  trainer_name: "Joey",
  intro: "My Rattata is in the top percentage!",
  after_text: "No way!",
  switch: 100  # Switch 100 wird nach Sieg gesetzt
)
```

### Gift Pokémon

```ruby
EventTemplates.execute(:gift_pokemon,
  species: :PIKACHU,
  level: 5,
  item: :LIGHTBALL,
  shiny: false,
  nature: :JOLLY,
  moves: [:THUNDERBOLT, :QUICKATTACK, :IRONTAIL, :SURF],
  text_before: "Take this Pikachu!",
  text_after: "It's very special!"
)
```

### Shop

```ruby
EventTemplates.execute(:shop,
  items: [:POKEBALL, :POTION, :ANTIDOTE, :PARALYZEHEAL, :AWAKENING, :BURNHEAL]
)
```

### Berry Tree

```ruby
EventTemplates.execute(:berry_tree, berry: :ORANBERRY, quantity: 3)
```

### Cut Tree

```ruby
EventTemplates.execute(:cut_tree)
```

### Rock Smash (mit verstecktem Item)

```ruby
EventTemplates.execute(:smash_rock, item: :STARPIECE)
```

### Rock Smash (mit verstecktem Pokémon)

```ruby
EventTemplates.execute(:smash_rock,
  pokemon_species: :SHUCKLE,
  pokemon_level: 10
)
```

### Roaming Legendary

```ruby
EventTemplates.execute(:release_roaming,
  species: :ENTEI,
  level: 40,
  text: "Entei fled into the distance!"
)
```

### Gym Leader

```ruby
EventTemplates.execute(:gym_leader,
  trainer_type: :LEADER_Brock,
  trainer_name: "Brock",
  badge_id: 0,
  badge_name: "Boulder Badge",
  tm_item: :TM39,  # Rock Tomb
  prize_money: 8000,
  intro: "I'll show you the power of Rock types!",
  defeat_text: "Your Pokémon's strength overcame my rocks!",
  badge_text: "You've earned the Boulder Badge!"
)
```

### Locked Door

```ruby
EventTemplates.execute(:locked_door,
  key_item: :CARDKEY,
  target_map: 5,
  target_x: 10,
  target_y: 15
)
```

### Legendary Encounter

```ruby
EventTemplates.execute(:legendary_encounter,
  species: :MEWTWO,
  level: 70,
  text_before: "A mysterious force is blocking your path!",
  text_caught: "You caught Mewtwo!",
  text_defeat: "Mewtwo vanished!"
)
```

## Eigene Templates erstellen

### Einfaches Template

```ruby
event_template :my_simple_event do
  message("Hello!")
  give_item(:POTION, 5)
  heal_party
end
```

### Template mit Parametern

```ruby
event_template :give_starter do |species:, nickname: nil|
  message("Professor: Here's your first Pokémon!")
  give_pokemon(species, 5, moves: [:TACKLE, :GROWL])
  message("Take good care of #{species}!")
end

# Nutzen:
EventTemplates.execute(:give_starter, species: :BULBASAUR)
```

### Template mit Conditionals

```ruby
event_template :daily_berry do |berry:|
  if_switch(500) do  # Switch 500 = Heute schon bekommen
    message("Come back tomorrow for more berries!")
  end.else do
    message("Here's today's berry!")
    give_item(berry, 1)
    set_switch(500, true)
  end
end
```

### Verschachteltes Template

```ruby
event_template :full_heal_service do |price: 500|
  message("I can heal your Pokémon for $#{price}!")
  choices(["Yes", "No"]) do |choice|
    if choice == 0
      if_value("$player.money >= #{price}") do
        give_money(-price)
        heal_party
        message("Your Pokémon are healed!")
      end.else do
        message("You don't have enough money!")
      end
    else
      message("Come back if you change your mind!")
    end
  end
end
```

## Integration mit Map System

Du kannst Templates mit dem Map Trainer System kombinieren:

```ruby
# In PBS/Maps/Trainers.rb
module Data::Trainers
  class Map5 < GameData::MapTrainer
    register 10, :YOUNGSTER, "Joey" do |trainer|
      trainer.intro = "My Rattata is different!"
      trainer.lose_text = "What?!"
      trainer.party = [
        Pokemon.new(:RATTATA, 15).with_item(:FOCUSSASH)
      ]
    end
  end
end

# Im Event (Script-Command):
# Statt manuell pbTrainerBattle zu callen:
EventTemplates.execute(:trainer_battle,
  trainer_type: :YOUNGSTER,
  trainer_name: "Joey",
  switch: 100
)
```

## Best Practices

### 1. Template-Namen beschreibend wählen

```ruby
# Gut:
event_template :gym_entrance_guard
event_template :mystery_gift_deliverer

# Schlecht:
event_template :event1
event_template :thing
```

### 2. Defaults für optionale Parameter

```ruby
event_template :healer do |price: 0, message: "Would you like me to heal your Pokémon?"|
  # ...
end
```

### 3. Switches für einmalige Events

```ruby
event_template :story_event do
  if_switch(200) do
    message("That already happened.")
  end.else do
    message("Important story moment!")
    # ... story stuff ...
    set_switch(200, true)
  end
end
```

### 4. Gruppiere verwandte Templates

```ruby
# Alle Gym-Leader in einem File
event_template :gym_1_brock do |...|
event_template :gym_2_misty do |...|
event_template :gym_3_surge do |...|
```

### 5. Nutze `use_template` für Wiederverwendung

```ruby
event_template :postgame_trainer do |trainer_type:, name:|
  message("A strong trainer approaches!")
  use_template(:trainer_battle,
    trainer_type: trainer_type,
    trainer_name: name,
    switch: nil  # Repeatable
  )
end
```

## Debugging

### Template existiert nicht?

```ruby
if EventTemplates.exists?(:my_template)
  EventTemplates.execute(:my_template)
else
  puts "Template not found!"
end
```

### Alle Templates anzeigen

```ruby
p EventTemplates.instance_variable_get(:@templates).keys
```

### Template testen

```ruby
# In Debug Console (F12):
EventTemplates.execute(:item_ball, item: :MASTERBALL)
```

## Erweiterte Beispiele

### Multi-Stage Event (Questline)

```ruby
event_template :scientist_quest do
  if_switch(301) do
    # Stage 3: Completed
    message("Thanks for the fossils! Here's your reward!")
    if_has_item(:HELIXFOSSIL) do
      message("Oh, you have another fossil? Let me revive it!")
      # Revive logic
    end
  elsif_switch(300) do
    # Stage 2: Task given
    if_has_item(:HELIXFOSSIL) && if_has_item(:DOMEFOSSIL) do
      message("You found both fossils! Amazing!")
      give_item(:MASTERBALL, 1)
      give_money(10000)
      set_switch(301, true)
    end.else do
      message("Still searching for those fossils?")
    end
  end.else do
    # Stage 1: Introduction
    message("I'm researching ancient Pokémon!")
    message("Could you find me a Helix Fossil and Dome Fossil?")
    set_switch(300, true)
  end
end
```

### Dynamic Trainer Battle (ändert sich mit Story)

```ruby
event_template :rival_dynamic do
  if_has_badge(8) do
    # Post-game Rival
    battle_trainer(:RIVAL, "Blue", 5)
  elsif_has_badge(4) do
    # Mid-game Rival
    battle_trainer(:RIVAL, "Blue", 3)
  end.else do
    # Early-game Rival
    battle_trainer(:RIVAL, "Blue", 1)
  end
end
```

### Time-based Event

```ruby
event_template :daily_lottery do
  # Pseudo-Code, Zeit-Check müsste implementiert werden
  script("today = Time.now.strftime('%Y-%m-%d')")

  if_value("$game_variables[100] == today") do
    message("Come back tomorrow for another chance!")
  end.else do
    message("Welcome to the daily lottery!")
    # Lottery logic
    script("$game_variables[100] = today")
  end
end
```

## FAQ

**Q: Kann ich RMXP Events und Templates mischen?**  
A: Ja! Du kannst aus RMXP-Events `EventTemplates.execute()` callen.

**Q: Funktionieren alte Events noch?**  
A: Ja, das System ist komplett optional.

**Q: Wie kann ich Parameter an Templates übergeben?**  
A: Mit Ruby's Keyword Arguments: `EventTemplates.execute(:name, param1: value1)`

**Q: Kann ich Templates in anderen Plugins definieren?**  
A: Ja! Einfach `event_template :name do ... end` irgendwo schreiben.

**Q: Werden Templates kompiliert?**  
A: Nein, wie bei Luka's System - sie werden direkt geladen und ausgeführt.

## Vergleich zu RMXP Events

### RMXP (Old Way):

1. Öffne Editor
2. Erstelle Event
3. Doppelklick für Event Commands
4. Füge 20+ Commands manuell hinzu
5. Copy-Paste ist mühsam
6. Keine Versionskontrolle
7. Schwer zu teilen

### Templates (New Way):

```ruby
EventTemplates.execute(:item_ball, item: :POTION)
```

**Eine Zeile. Fertig.**

## Credits

Based on Luka's templating philosophy: "I made an entire templating engine for events and rewrote most of the PBS based components into something I like more. Don't have to leave the IDE much at all these days."
