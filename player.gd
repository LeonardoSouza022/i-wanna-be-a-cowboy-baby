
extends CharacterBody2D

const jump_velocity = -300.0
@onready var sprite = $AnimatedSprite2D
@onready var colisionshape = $CollisionShape2D


var dead = false

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	move_and_slide()
	
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		if collision.get_collider().is_in_group("enemies"):
			die()

func die():
	if dead:
		return
		
	dead = true
	get_tree().paused = true
