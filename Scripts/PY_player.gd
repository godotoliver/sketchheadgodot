extends CharacterBody2D

# --------------------
# TODO STEP 25
# Create the physics variables
# --------------------
@export var x_velocity: float = 100
@export var y_velocity: float = -700
@export var gravity: float = 1200

#Platform Variables
@export var trampoline_boost : = -1400.0
var is_boosted := false
var is_inverted := 1

# --------------------
# TODO STEP 29
# Create the _process method
# --------------------
func _process(_delta: float) -> void:
	velocity.x = 0.0
	
	if Input.is_action_pressed("ui_left"):
		velocity.x = -x_velocity * is_inverted
		$Sprite2D.flip_h = true
	if Input.is_action_pressed("ui_right"):
		velocity.x = x_velocity * is_inverted
		$Sprite2D.flip_h = false

# --------------------
# TODO STEP 51
# Create the _physics_process method
# --------------------
func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	
	var platform_collision:KinematicCollision2D = get_last_slide_collision()
	if platform_collision != null: #Checks if the player has collided with something
		 #=PY= Sets the player controls to normal
		is_boosted = false
		is_inverted = 1 
		if (platform_collision.get_collider().is_in_group("InvertedPlatform")):#Checks if the group of the collider returns InvertedPlatform
			is_inverted = -1 #Inverts the Players controls 
		elif (platform_collision.get_collider().is_in_group("TrampolinePlatform")):#Checks if the group of the collider returns TrampolinePlatform
			is_boosted = true #Sets the player to a boosted state
		elif (platform_collision.get_collider().is_in_group("DisappearingPlatform")):#Checks if the group of the collider returns DisappearingPlatform
			platform_collision.get_collider().queue_free() #=PY= Destroys the platform on collision
	
	if is_on_floor():
		if (is_boosted):
			velocity.y = trampoline_boost
		else:
			velocity.y = y_velocity
	
	move_and_slide()
