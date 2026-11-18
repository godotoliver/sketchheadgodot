extends Node

var score := 0
signal score_changed(new_score) # Lets the script know that score has changed

func set_score(amount: int) -> void:
	score = amount
	emit_signal("score_changed", score) # Connected scripts are notified of score change
