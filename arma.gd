extends Node2D

const BALA = preload("res://bala.tscn")
@onready var cano: Marker2D = $Marker2D
var escala_inicial: Vector2

func _ready() -> void:
	escala_inicial = scale

func _process(_delta: float) -> void:
	look_at(get_global_mouse_position())

	rotation_degrees = wrap(rotation_degrees, 0, 360)

	if rotation_degrees > 90 and rotation_degrees < 270:
		scale = Vector2(escala_inicial.x, -escala_inicial.y)
	else:
		scale = escala_inicial

	if Input.is_action_just_pressed("atirar"):
		var instancia_bala = BALA.instantiate()
		get_tree().root.add_child(instancia_bala)
		instancia_bala.global_position = cano.global_position
		instancia_bala.global_rotation = global_rotation
