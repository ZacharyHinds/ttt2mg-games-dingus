# ttt2mg-games-dingus
This is a collection of minigames for TTT2 Minigames.

## Why aren't these included in the Randomat collection?
I've separated out these minigames because by and large, all the games in the Randomat are not of my original design, but instead rewritten events from the variety of Randomat versions available.

Almost all of the games included in this collection are based on ideas that I came up with or that were provided by people on my server, with the exception of Accuracy, Pinball, and Recoil which are based on Owningle's extra randomat events.

That said, due to the way the TTT2 Minigames work, this collection is 100% compatible with the TTT2 Minigames Randomat and are able to be activated by using the Randomat.

# Minigames

## Completed Minigames

### Accuracy Training
* Name: sh_accuracy_minigame
* Description: Deals damage to the shooter when they miss, heals them if they hit.
* ConVars:
  * ttt2_minigames_accuracy_dmg - Damage dealt on a miss
  * ttt2_minigames_accuracy_heal  - Health healed on a hit

### Amnesia
* Name: sh_amnesia_minigame
* Description: One Detective, One Traitor, One Serialkiller, and everyone else if an Amnesiac
* Addon Dependencies:
  * [[TTT2] Amnesiac [ROLE]](https://steamcommunity.com/sharedfiles/filedetails/?id=2001213453)
* ConVars:
  * ttt2_minigames_amnesia_dethealth  - Detective's health
  * ttt2_minigames_amnesia_detarmor - Detective's armor

### Lights Out!
* Name: sh_dark_minigame
* Description: Disables map light style, usually making the map very dark

### Spider-Terrorists!
* Name: sh_grapple_minigame
* Description: Everyone gets a grapple hook and the climb item
* Addon Dependencies:
  * [Grapple Hook](https://steamcommunity.com/sharedfiles/filedetails/?id=265714452)
  * [[TTT2] Climb [ITEM]](https://steamcommunity.com/sharedfiles/filedetails/?id=1840323666)

### Grayscale
* Name: sh_grayscale_minigame
* Description: Turns the color saturation way down

### Groundhog Day
* Name: sh_groundhog_minigame
* Description: Every 60 seconds, resets everyone to a random spawnpoint
* ConVars:
  * ttt2_minigames_groundhog_timer  - delay between "resets"

### There are ghosts around
* Name: sh_haunting_minigame
* Description: Ghostly t-posing models follow spectators
* Known Bugs:
  * The Ghosts do not update position after spawning

### Trouble in Ye Olde Terrorist Towne
* Name: sh_medieval_minigame
* Description: Replaces weapons with infinite-shot bow and shovel
* Addon Dependencies:
  * [TTT Hunting Bow](https://steamcommunity.com/sharedfiles/filedetails/?id=1372718426)
  * [Shovel for TTT](https://steamcommunity.com/sharedfiles/filedetails/?id=647112181)

### Trouble in Terrorist Town: On Ice
* Name: sh_onice_minigame
* Description: Removes friction (also gives prop damage immunity)
* ConVars:
  * ttt2_minigames_onice_friction - Friction during minigame
  * ttt2_minigames_onice_nopropdmg  - Enable/Disable prop damage immunity

### Pinball
* Name: sh_pinball_minigame
* Description: Players bounce off one another
* ConVars:
  * ttt2_minigames_pinball_mult - Velocity multiplier for collisions

### Prop Hunt-ish
* Name: sh_prophunt_minigame
* Description: Gives every player a prop disguiser and prop damage immunity
* Addon Dependencies:
  * [Prop Disguiser](https://steamcommunity.com/sharedfiles/filedetails/?id=1662844145)

### Recoil
* Name: sh_recoil_minigame
* Description: Weapons propel players backwards based on damage
* ConVars:
  * ttt2_minigames_recoil_max - Maximum velocity from recoil

### Crime Reporter
* Name: sh_report_minigame
* Description: Alerts everyone when a player dies

### RESTLESS DEAD!
* Name: sh_restless_minigame
* Description: Dead players will revive as a Restless
* Addon Dependencies:
  * [[TTT2] Restless [ROLE]](https://steamcommunity.com/sharedfiles/filedetails/?id=2185765394)
* ConVars:
  * ttt2_minigames_restless_deaths  - Amount to subtract from minigame Restless' lives
  * ttt2_minigames_restless_delay - Respawn delay for minigame

### Took Too Much
* Name: sh_trippy_minigame
* Description: Trippy visuals

### Troll Prop
* Name: sh_trollprop_minigame
* Description: Buffs spectator prop possession
* ConVars:
  * ttt2_minigames_trollprop_multiplier - Multiplier applied to spectator prop settings

### Unknowns
* Name: sh_unknowns_minigame
* Description: One Detective, One Traitor, everyone else is an Unknown
* Addon Dependencies:
  * [[TTT2] Unknown [ROLE]](https://steamcommunity.com/sharedfiles/filedetails/?id=1457185541)
* ConVars:
  * ttt2_minigames_unknowns_dethealth - Detective's health
  * ttt2_minigames_unknowns_detarmor  - Detective's armor

### Temporal Flux
* Name: sh_wobbly_minigame
* Description: At a set interval, changes the gravity and game time scale
* ConVars:
  * ttt2_minigames_wobbly_max_grav  - Maximum gravity
  * ttt2_minigames_wobbly_min_grav  - Minimum gravity
  * ttt2_minigames_wobbly_max_speed - Maximum time scale
  * ttt2_minigames_wobbly_min_speed - Minimum time scale
  * ttt2_minigames_wobbly_universal_grav  - Should all players have the same gravity

### Karmic Wrath
* Name: sh_wrath_minigame
* Description: Deals damage to everyone based on their karma
