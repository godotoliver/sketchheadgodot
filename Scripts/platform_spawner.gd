extends Node2D

# Node References
@export var platform: StaticBody2D
@export var camera: Camera2D
@export var player: CharacterBody2D
# Exported Variables
@export var platform_spacing: float = 200.0

# Platform Variables
var min_spawn_x: float = -200
var max_spawn_x: float = 200
var platforms_max:  int = 5
var last_platform_y: float = 0.0 # Keep track of the last platforms vertical position


# This loop will spawn the initial platforms
func _ready():
	last_platform_y = platform.position.y
	
	for i in range(platforms_max):
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
	var new_platform = platform.duplicate() # Duplicate the initial platform
	var random_x_position = randf_range(min_spawn_x, max_spawn_x) # Random platform horizontal position
	var new_y_position = last_platform_y - platform_spacing  # New platform is vertically spaced
	
	new_platform.position = Vector2(random_x_position, new_y_position) # Set position of new platform
	last_platform_y = new_y_position # Keep track of its Y position
	add_child(new_platform)
