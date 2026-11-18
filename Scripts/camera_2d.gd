extends Camera2D

# --------------------
# TODO STEP 65
# Create the player variable
# --------------------
@export var player: CharacterBody2D

# --------------------
# TODO STEP 66
# Create the _process method
# --------------------
func _process(_delta: float) -> void:
	if player.position.y < position.y:
		position.y = player.position.y
