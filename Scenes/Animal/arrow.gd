extends Node2D

var radius = 50 #distance from center
var angle = 0.0 #Initial angle
var _start = Vector2.ZERO
var _center_position = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_center_position = get_parent().global_position + Vector2(20,-20)
	_start = position

func _physics_process(delta: float) -> void:
	move_arrow()
	
func move_arrow() -> void:
	#Moves the arrow rotation towards the original spot
	var direction = (_center_position - get_parent().global_position).normalized()
	angle = direction.angle()
	rotation = angle
	#Move the arrow to the position around the radius
	position =  _start + Vector2(cos(angle), sin(angle)) + direction * radius
