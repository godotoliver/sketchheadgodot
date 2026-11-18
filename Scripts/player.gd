extends CharacterBody2D

# --------------------
# TODO STEP 25
# Create the physics variables
# --------------------
@export var x_velocity: float = 100
@export var y_velocity:  float = -700
@export var gravity: float = 1200

# --------------------
# TODO STEP 29
# Create the _process method
# --------------------
func _process(_delta: float) -> void:
	velocity.x = 0
	if Input.is_action_pressed("ui_left"):
		velocity.x = -x_velocity
		$Sprite2D.flip_h = true
	if Input.is_action_pressed("ui_right"):
		velocity.x = x_velocity
		$Sprite2D.flip_h = false

# --------------------
# TODO STEP 51
# Create the _physics_process method
# --------------------
func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	if is_on_floor():
		velocity.y = y_velocity
	
	move_and_slide()
