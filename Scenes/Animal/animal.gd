extends RigidBody2D

enum ANIMAL_STATE {READY, DRAG, RELEASE}
var _state : ANIMAL_STATE = ANIMAL_STATE.READY

@onready
var onscreen_notifier : VisibleOnScreenNotifier2D = $OffScreenNotifier
@onready
var state_label : Label = $StateLabel
@onready
var arrow : Node2D = $Arrow
@onready
var stretch_sound : AudioStreamPlayer2D = $Arrow/StretchSound

var _start : Vector2
const DRAG_LIMIT_MIN : Vector2 = Vector2(-60,0)
const DRAG_LIMIT_MAX : Vector2 = Vector2(0,60)
var _drag_start : Vector2
var _drag_vector : Vector2
var prev_drag_vector : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	onscreen_notifier.screen_exited.connect(die)
	self.input_event.connect(process_input_event)
	_start = position
	arrow.hide()


func _physics_process(delta):
	update(delta)
	state_label.text = "%s\n" % ANIMAL_STATE.keys()[_state]
	state_label.text += "%.1f, %.1f" % [_drag_vector.x, _drag_vector.y]


func update(delta) -> void:
	match _state:
		ANIMAL_STATE.DRAG:
			update_drag()
				
#Clamp the drag position and the starting position to be within the bounds of the rectangle we want the user to be able to move the animal
func get_drag_vector(gmp: Vector2) -> Vector2:
	prev_drag_vector = _drag_vector
	_drag_vector = gmp - _drag_start
	_drag_vector.x = clampf(_drag_vector.x, DRAG_LIMIT_MIN.x, DRAG_LIMIT_MAX.x)
	_drag_vector.y = clampf(_drag_vector.y, DRAG_LIMIT_MIN.y, DRAG_LIMIT_MAX.y)
	return _drag_vector

func update_drag() -> void:
	if detect_release() == true:
		return
	#Move animal with the vector difference limited
	play_stretch_sound()
	position = _start + get_drag_vector(get_global_mouse_position())
	point_arrow()
	

func detect_release() -> bool:
	if _state == ANIMAL_STATE.DRAG:
		if Input.is_action_just_released("drag"):
			set_new_state(ANIMAL_STATE.RELEASE)
			return true
			
	return false


func set_new_state(new_state: ANIMAL_STATE) -> void:
	_state = new_state
	if _state == ANIMAL_STATE.RELEASE:
		freeze = false
		arrow.hide()
	elif _state == ANIMAL_STATE.DRAG:
		#Set the drag start to get difference between mouse and center start of animal
		_drag_start = get_global_mouse_position()
		arrow.show()


#Process whether user is grabbing the bird to pull
func process_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if _state == ANIMAL_STATE.READY and event.is_action_pressed("drag"):
		set_new_state(ANIMAL_STATE.DRAG)
		

		
func die() -> void:
	SignalManager.die.emit()
	queue_free()

func point_arrow() -> void:
	arrow.rotation = (_start - position).angle()

func play_stretch_sound() -> void:
	if (prev_drag_vector - _drag_vector).length() > 0 and stretch_sound.playing == false:
		stretch_sound.play()
