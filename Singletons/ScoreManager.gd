extends Node

signal update_score

var _selected_level : int:
	get = get_selected_level,
	set = set_selected_level
	
var _level_score : int:
	get = get_level_score,
	set = set_level_score

var _level_attempts: int:
	get = get_level_attempts,
	set = set_level_attempts

func _ready() -> void:
	_selected_level = 1
	_level_score = 0

func get_selected_level() -> int:
	return _selected_level

func set_selected_level(value: int)-> void:
	_selected_level = value

func get_level_score() -> int:
	return _level_score
	
func set_level_score(value: int) -> void:
	_level_score = value
	
func get_level_attempts() -> int:
	return _level_attempts
	
func set_level_attempts(value: int) -> void:
	_level_attempts = value
