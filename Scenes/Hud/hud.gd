extends Control

@onready
var _attempts_made_label = $MC/VC/AttemptsHC/AttemptsNumber
@onready
var _score_label = $MC/VC/ScoreHC/ScoreNumber

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.attemp_made.connect(_update_attempts)
	SignalManager.attempt_successful.connect(_update_score)


func _update_attempts() -> void:
	_attempts_made_label.text = str(ScoreManager.get_level_attempts())

func _update_score() -> void:
	_score_label.text = str(ScoreManager.get_level_score())
