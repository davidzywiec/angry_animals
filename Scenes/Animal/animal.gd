extends RigidBody2D

@onready
var onscreen_notifier : VisibleOnScreenNotifier2D = $OffScreenNotifier

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	onscreen_notifier.screen_exited.connect(die)


func _physics_process(delta):
	pass
		
func die() -> void:
	SignalManager.die.emit()
	queue_free()
