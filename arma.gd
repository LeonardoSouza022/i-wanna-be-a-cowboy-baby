extends Node2D

const BALA = preload("res://node_2d.tscn")
@onready var cano: Marker2D = $Marker2D

func _process(delta: float) -> void:
	look_at(get_global_mouse_position())
 
	rotation_degrees = wrap(rotation_degrees, 0, 360)
	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.y = -1
	else:
		scale.y = 1
		
		if Input.is_action_just_pressed("atirar"):
			var instancia_bala = BALA.instantiate()
			get_tree().root.add_child(instancia_bala)
			instancia_bala.global_position =  cano.global_position
			instancia_bala.rotation = rotation
