extends Node

@export
var _level_number : int = 0

var _attempts : int = 0
var _cups : int = 0
var _successes : int = 0

func _ready() -> void:
	_cups = get_tree().get_nodes_in_group("cup").size()
	SignalManager.attempt_successful.connect(destroy_cup)
	SignalManager.attemp_made.connect(attempt_made)
	
func destroy_cup() -> void:
	_successes += 1
	ScoreManager.level_score = _successes
	SignalManager.update_score.emit()
	if _successes == _cups:
		ScoreManager.save_score(_level_number, _attempts, _successes)
		SignalManager.game_over.emit(true)

func attempt_made() -> void:
	_attempts+= 1
	ScoreManager.level_attempts = _attempts
	SignalManager.update_score.emit()
	
func save_score() -> void:
	pass
	
func load_high_score() -> void:
	pass
