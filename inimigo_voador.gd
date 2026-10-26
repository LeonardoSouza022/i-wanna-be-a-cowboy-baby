extends CharacterBody2D

@export var speed: float = 120.0
@export var amplitude: float = 35.0
@export var frequency: float = 2.0

var start_y: float
var movement_time: float

func _ready() -> void:
	start_y = global_position.y
	movement_time = randf_range(0.0, TAU)

func _process(delta: float) -> void:
	global_position.x -= speed * delta
	movement_time += delta * frequency
	global_position.y = start_y + sin(movement_time) * amplitude

	if global_position.x < -200:
		queue_free()
