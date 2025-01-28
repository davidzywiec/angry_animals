extends Node2D

@onready
var spawn_marker : Marker2D = $SpawnMarker

@export
var level_seconds : int = 0

const ANIMAL = preload("res://Scenes/Animal/animal.tscn")
const MENU = preload("res://Scenes/Main/main.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_animal()
	SignalManager.die.connect(spawn_animal)
	SignalManager.set_level_time.emit(level_seconds)
	SignalManager.restart.connect(restart_level)
	
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_packed(MENU)

func spawn_animal() -> void:
	var new_animal = ANIMAL.instantiate()
	new_animal.global_position = spawn_marker.global_position
	add_child(new_animal)
	
func restart_level() -> void:
	ScoreManager.reset_level()
	get_tree().reload_current_scene()	
