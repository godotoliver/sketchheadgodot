extends Node2D

# Node References
@export var platform : StaticBody2D
@export var camera : Camera2D
@export var player : CharacterBody2D
@export var platform_spacing: float = 200.0
# New platforms (as scene?)
@export var inverted_platform : PackedScene
@export var trampoline_platform : PackedScene
@export var disappearing_platform : PackedScene

# Platform Variables
var min_spawn_x: float = -200
var max_spawn_x: float = 200
var starting_platforms_count: int = 5
var last_platform_y: float = 0.0 # Keep track of the last platforms vertical position

# New Platform placement variables
# Ensure these values do not add over 1.0 to avoid errors
var inverted_chance: float = 0.2
var trampoline_chance: float = 0.4
var disappearing_chance: float = 0

# This loop will spawn the initial platforms
func _ready():
	last_platform_y = platform.position.y
	
	for i in range(starting_platforms_count):
		spawn_platform()

func _process(_delta: float) -> void:
	# Platforms that leave camera view will be removed
	var camera_y = camera.global_position.y 
	for j in get_children():
		if j.position.y > camera_y + 600:  
			j.queue_free()
	
	# Detect if player is near top platform and spawn new platforms
	var player_pos = player.global_position
	if player_pos.y < (last_platform_y + 400):
		for k in range(2):
			spawn_platform()

func spawn_platform():
	var random_x_position = randf_range(min_spawn_x, max_spawn_x) # Random platform horizontal position
	var new_y_position = last_platform_y - platform_spacing
	
	# THE CHANCES OF EACH PLATFORM MUST BE SEGMENTED TO WORK IN THE FOLLOWING EXAMPLE:
	# 0.0                              0.5                                 1.0
	#  |------------|------------------------|------------------|-----------|
	#  |  Inverted  |       Trampoline       |   Disappearing   |  Default  |
	#  |------------|------------------------|------------------|-----------|
	var new_platform: Node
	var r := randf() # randf() generates a random decimal number 0.0 - 1.0
	
	if (r < inverted_chance): 
		# 0.0 -> inverted_chance
		new_platform = inverted_platform.instantiate()
	elif(r < inverted_chance + trampoline_chance): 
		# inverted_chance -> inverted_chance + trampoline_chance
		new_platform = trampoline_platform.instantiate()
	elif(r < inverted_chance + trampoline_chance + disappearing_chance):
		# inverted_chance + trampoline_chance -> inverted_chance + trampoline_chance + disappearing_chance
		new_platform = disappearing_platform.instantiate()
	else:
		# inverted_chance + trampoline_chance + disappearing_chance -> 1.0
		new_platform = platform.duplicate()
		
	new_platform.position = Vector2(random_x_position, new_y_position) # Set position of new platform
	last_platform_y = new_y_position
	add_child(new_platform)
