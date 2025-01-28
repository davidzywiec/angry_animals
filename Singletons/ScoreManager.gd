extends Node

var score_dictionary = {}
var level_attempts : int = 0
var level_score : int = 0

func _ready() -> void:
	load_high_scores_from_file()

func load_high_scores_from_file() -> void:
	var file = FileAccess.open("user://score_data.json",FileAccess.READ)
	if file:
		var json_dat = JSON.new()
		var parse_results = json_dat.parse(file.get_line())
		if not parse_results == OK:
			print("JSON Parse Error: ", json_dat.get_error_message(), " in ", file.get_line(), " at line ", json_dat.get_error_line())
		else:
			score_dictionary = json_dat.data
	SignalManager.update_high_scores.emit()
			
func save_high_scores_to_file() -> void:
	var file = FileAccess.open("user://score_data.json",FileAccess.WRITE)
	file.store_line(get_data_as_json())
	SignalManager.update_high_scores.emit()

func reset_level() -> void:
	level_attempts = 0
	level_score = 0

func get_data_as_json() -> String:
	return JSON.stringify(score_dictionary)

func save_score(level: int, attemps: int, score: int) -> void:
	var score_data =  {
		"score" : score,
		"attemps": attemps
	}

	if score_dictionary.has(str(level)):
		if score_dictionary[str(level)].score < score_data.score:
			score_dictionary[str(level)] = score_data
			save_high_scores_to_file()
	else:
		score_dictionary[str(level)] = score_data
		save_high_scores_to_file()
		
func get_high_score(level : int) -> int:
	if not score_dictionary.has(str(level)):
		return 0
	else:
		return score_dictionary[str(level)].score
