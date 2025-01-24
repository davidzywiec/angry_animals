extends Node2D

@onready
var spawn_marker : Marker2D = $SpawnMarker

const ANIMAL = preload("res://Scenes/Animal/animal.tscn")
const MENU = preload("res://Scenes/Main/main.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_animal()
	SignalManager.die.connect(spawn_animal)
	
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene_to_packed(MENU)

func spawn_animal()->void:
	var new_animal = ANIMAL.instantiate()
	new_animal.global_position = spawn_marker.global_position
	add_child(new_animal)
