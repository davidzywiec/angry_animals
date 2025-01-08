extends Area2D

@onready var splash : AudioStreamPlayer2D = $Splash

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.body_entered.connect(start_splash_sound)


func start_splash_sound(body: Node2D) -> void:
	splash.play(0)