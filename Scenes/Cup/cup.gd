extends StaticBody2D

@onready
var anim_player : AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	anim_player.animation_finished.connect(anim_finish)

func die() -> void:
	ScoreManager._level_score += 1
	anim_player.play("vanish")

func anim_finish(_anim_name: String) -> void:
	SignalManager.attempt_successful.emit()
	queue_free()
