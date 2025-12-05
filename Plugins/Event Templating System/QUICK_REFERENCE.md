# Event Templates - Quick Reference

## Häufigste Templates

### Item geben

```ruby
EventTemplates.execute(:item_ball, item: :POTION, quantity: 1)
EventTemplates.execute(:hidden_item, item: :RARECANDY)
```

### Trainer Battle

```ruby
EventTemplates.execute(:trainer_battle,
  trainer_type: :YOUNGSTER,
  trainer_name: "Joey",
  intro: "Let's battle!",
  after_text: "You won!",
  switch: 100
)
```

### NPC Healing (Nurse Joy)

```ruby
EventTemplates.execute(:nurse_joy)
```

### Pokemon geben

```ruby
EventTemplates.execute(:gift_pokemon,
  species: :PIKACHU,
  level: 25,
  item: :LIGHTBALL,
  shiny: false
)
```

### Shop

```ruby
EventTemplates.execute(:shop,
  items: [:POKEBALL, :POTION, :ANTIDOTE]
)
```

### Legendäres Pokemon (einmalig)

```ruby
EventTemplates.execute(:legendary_encounter,
  species: :MEWTWO,
  level: 70
)
```

### Gym Leader

```ruby
EventTemplates.execute(:gym_leader,
  trainer_type: :LEADER_Brock,
  trainer_name: "Brock",
  badge_id: 0,
  badge_name: "Boulder Badge",
  tm_item: :TM39
)
```

---

## In RMXP benutzen

**3 Schritte:**

1. Event erstellen
2. Script-Command hinzufügen
3. `EventTemplates.execute(:template_name, params...)`

**Beispiel:**

```ruby
EventTemplates.execute(:item_ball, item: :POTION)
```

---

## Eigenes Template definieren

```ruby
event_template :my_event do |param1:, param2: "default"|
  message("Hello #{param1}!")
  give_item(param2, 1)
end
```

Dann benutzen:

```ruby
EventTemplates.execute(:my_event, param1: "World", param2: :POKEBALL)
```

---

## DSL Commands

| Command                         | Beispiel                                              |
| ------------------------------- | ----------------------------------------------------- |
| `message(text)`                 | `message("Hello!")`                                   |
| `choices(options)`              | `choices(["Yes", "No"]) { \|c\| ... }`                |
| `give_item(item, qty)`          | `give_item(:POTION, 5)`                               |
| `give_pokemon(sp, lv, **opts)`  | `give_pokemon(:PIKACHU, 25, shiny: true)`             |
| `give_money(amount)`            | `give_money(5000)`                                    |
| `battle_wild(sp, lv)`           | `battle_wild(:PIDGEY, 5)`                             |
| `battle_trainer(type, name, v)` | `battle_trainer(:YOUNGSTER, "Ben", 0)`                |
| `heal_party()`                  | `heal_party()`                                        |
| `open_pc()`                     | `open_pc()`                                           |
| `open_mart(items)`              | `open_mart([:POKEBALL, :POTION])`                     |
| `transfer_player(m, x, y)`      | `transfer_player(5, 10, 12)`                          |
| `set_switch(id, val)`           | `set_switch(100, true)`                               |
| `set_variable(id, val)`         | `set_variable(50, 123)`                               |
| `if_switch(id) { ... }`         | `if_switch(100) { message("Done!") }`                 |
| `if_has_item(item) { ... }`     | `if_has_item(:POTION) { message("Has potion") }`      |
| `if_has_pokemon(sp) { ... }`    | `if_has_pokemon(:PIKACHU) { message("Has Pikachu") }` |
| `if_has_badge(id) { ... }`      | `if_has_badge(1) { message("Has badge 1") }`          |
| `wait(frames)`                  | `wait(20)`                                            |
| `play_se(file, vol, pitch)`     | `play_se("Door exit", 100, 100)`                      |
| `play_me(file, vol, pitch)`     | `play_me("Item get", 100, 100)`                       |
| `play_bgm(file, vol, pitch)`    | `play_bgm("Battle trainer", 100, 100)`                |
| `fade_screen()`                 | `fade_screen()`                                       |
| `script(code)`                  | `script("p 'Hello'")`                                 |
| `use_template(name, **p)`       | `use_template(:item_ball, item: :POTION)`             |

---

## Alle vorgefertigten Templates

- `:item_ball` - Item Ball auf Map
- `:hidden_item` - Verstecktes Item (Itemfinder)
- `:nurse_joy` - Pokemon Center Healing
- `:trainer_battle` - Einfacher Trainer
- `:gift_pokemon` - Pokemon geschenkt bekommen
- `:pc_and_heal` - PC zu Hause
- `:shop` - Poke Mart
- `:berry_tree` - Beeren-Baum
- `:cut_tree` - Zerschneidbarer Baum
- `:smash_rock` - Zertrümmerbarer Stein
- `:release_roaming` - Roaming Pokemon freilassen
- `:evolution_stone` - Evolution Stone Event
- `:sign` - Schild/Hinweisschild
- `:rival_battle` - Rival mit Story-Progress
- `:gym_leader` - Gym Leader Battle
- `:weather_changer` - Wetter ändern
- `:legendary_encounter` - Legendäres Pokemon
- `:locked_door` - Verschlossene Tür (braucht Key Item)
- `:tutorial_npc` - Tutorial NPC (einmalig)

Siehe `README.md` für Details zu jedem Template!

---

## Tips

✅ **DO:**

- Nutze descriptive Namen für Templates
- Gebe Defaults für optionale Parameter an
- Nutze Switches für einmalige Events
- Gruppiere verwandte Templates in einem File

❌ **DON'T:**

- Nutze keine generischen Namen wie `:event1`
- Vergiss nicht die Switches zu setzen (sonst repeatable)
- Hardcode keine Map-IDs wenn möglich

---

## Debugging

```ruby
# Template existiert?
EventTemplates.exists?(:my_template)

# Alle Templates anzeigen
p EventTemplates.all

# Direkt testen (Debug Console F12)
EventTemplates.execute(:item_ball, item: :MASTERBALL)
```

---

**Mehr Infos: Siehe README.md**
