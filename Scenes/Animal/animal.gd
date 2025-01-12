extends RigidBody2D

enum ANIMAL_STATE {READY, DRAG, RELEASE}
var _state : ANIMAL_STATE = ANIMAL_STATE.READY

@onready
var onscreen_notifier : VisibleOnScreenNotifier2D = $OffScreenNotifier


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	onscreen_notifier.screen_exited.connect(die)


func _physics_process(delta):
	update(delta)


func on_input_event(viewport, event, shape_idx):
	print(event)


func update(delta) -> void:
	match _state:
		ANIMAL_STATE.DRAG:
			update_drag()
				

func update_drag() -> void:
	if detect_release() == true:
		return
		
	var gmp = get_global_mouse_position()
	position = gmp


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
	elif _state == ANIMAL_STATE.DRAG:
		pass

		
func die() -> void:
	SignalManager.die.emit()
	queue_free()
