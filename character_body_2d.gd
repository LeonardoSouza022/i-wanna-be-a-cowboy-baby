extends CharacterBody2D

@export var speed := 150

func _process(delta: float) -> void:
	position.x -= speed * delta
	
	if position.x < -200:
		queue_free()
