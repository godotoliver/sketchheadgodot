extends Node2D

@onready var player = $Player
@onready var camera = $Camera2D
@onready var platform = $Platform
@onready var game = get_node("UserInterface/GameControl")
@onready var score = get_node("UserInterface/ScoreControl")


var height_score: float = 0.0

func _ready() -> void:
	game.visible = false
	score.visible = true
	var button = get_node("UserInterface/GameControl/Button")
	button.pressed.connect(_on_button_pressed)

func _process(_delta: float) -> void:
	if player.velocity.y < 0 and player.global_position.y < -height_score:
		height_score = -player.global_position.y
		ScoreSystem.set_score(int(height_score))

	if player.position.y > camera.position.y + 648: ## The player falls beyond the camera (downwards)
		# Freeze the player and stop applying gravity
		player.velocity.y = 0.0
		player.gravity = 0 
		game_over()
		
func game_over():
	game.visible = true
	score.visible = false

func _on_button_pressed() -> void:
	get_tree().reload_current_scene()
