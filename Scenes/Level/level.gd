extends Node2D

@onready
var spawn_marker : Marker2D = $SpawnMarker

const ANIMAL = preload("res://Scenes/Animal/animal.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_animal()

func spawn_animal()->void:
	var new_animal = ANIMAL.instantiate()
	new_animal.global_position = spawn_marker.global_position
	add_child(new_animal)
