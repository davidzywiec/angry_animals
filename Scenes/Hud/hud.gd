extends Control

const MENU = preload("res://Scenes/Main/main.tscn")

@onready
var _attempts_made_label = $MC/VC/AttemptsHC/AttemptsNumber
@onready
var _score_label = $MC/VC/ScoreHC/ScoreNumber
@onready
var _timer_label = $MC/TimerLabel
@onready
var score_timer = $ScoreTimer
@onready
var game_over_hud = $GameOver_HUD
@onready
var win_hud = $WinHUD

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.update_score.connect(_update_score)
	SignalManager.set_level_time.connect(_set_level_time)
	SignalManager.game_over.connect(game_over)
	score_timer.timeout.connect(_timeout)

func _process(_delta: float) -> void:
	_timer_label.text = str(round(score_timer.time_left))

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_select"):
		if game_over_hud.visible:
			SignalManager.restart.emit()
		if win_hud.visible:
			get_tree().change_scene_to_packed(MENU)
	
func _update_score() -> void:
	_attempts_made_label.text = str(ScoreManager.level_attempts)
	_score_label.text = str(ScoreManager.level_score)
	
func _set_level_time(seconds: int) -> void:
	_timer_label.text = str(seconds)
	score_timer.start(seconds)

func _timeout() -> void:
	SignalManager.game_over.emit(false)
	
func game_over(win: bool) -> void:
	if 	win == true:
		
		win_hud.visible = true
	else:
		game_over_hud.visible = true
