extends TextureButton

#Scale variables
const HOVER_SCALE : Vector2 = Vector2(1.15,1.15)
const DEFAULT_SCALE : Vector2 = Vector2.ONE
var expanded = false

#Label variables
@onready
var level_label : Label = $MC/VBoxContainer/LevelLabel
@onready
var score_label : Label = $MC/VBoxContainer/ScoreLabel

#Level variables
@export
var level_num : int = 1
var level_scene : PackedScene

func _ready() -> void:
	mouse_entered.connect(scale_btn)
	mouse_exited.connect(scale_btn)
	pressed.connect(switch_scene)
	#Label the button based on the level
	level_label.text = str(level_num)
	level_scene = load("res://Scenes/Level/level_%s.tscn" % str(level_num))
	
func scale_btn() -> void:
	var tween = create_tween()
	
	if expanded:
		tween.tween_property(self, "scale", DEFAULT_SCALE, 0.5).from_current().set_trans(Tween.TRANS_SINE)
		expanded = false
	else:
		tween.tween_property(self, "scale", HOVER_SCALE, 0.5).from_current().set_trans(Tween.TRANS_EXPO)
		expanded = true
		
func switch_scene() -> void:
	get_tree().change_scene_to_packed(level_scene)
	
