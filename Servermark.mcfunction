# Spawn a zombie at the position of 0, ~, 0
execute as @a at @s run summon minecraft:zombie 0 ~ 0 {CustomName:"\"Zombie Spawn\"",CustomNameVisible:0b}

# Schedule the spawn_zombie function to run every 20 ticks
schedule function servermark:spawn_zombie 1t

# Function to spawn zombies
# Spawns a zombie at 0, ~, 0 for each player and schedules itself to run again in 20 ticks
# This ensures that zombies are continuously spawned until the TPS drops below 16
# Note: this function is called using the schedule command above
function servermark:spawn_zombie
execute as @a at @s run summon minecraft:zombie 0 ~ 0 {CustomName:"\"Zombie Spawn\"",CustomNameVisible:0b}
schedule function servermark:spawn_zombie 20t

# Function to count and kill zombies
# Counts the number of zombies with the 'Zombie Spawn' name and stores the count in the 'zombie_count' scoreboard
# If the TPS drops below 16, kills all zombies with the 'Zombie Spawn' name and announces the count in chat
# Note: this function should be run manually (e.g. using a command block) once the server TPS drops below 16
function servermark:count_and_kill_zombies
execute as @a run execute store result score @s zombie_count run execute as @e[type=zombie,name="Zombie Spawn"] run execute unless entity @s[name="Zombie Spawn"] positioned ~ ~ ~5
execute if score Server.TPS minecraft:custom < 16 run execute as @e[type=zombie,name="Zombie Spawn"] run kill @s
execute if score Server.TPS minecraft:custom < 16 run say The current number of zombies is: %score_zombie_count%
