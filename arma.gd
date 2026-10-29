extends Node2D

const BALA = preload("res://bala.tscn")
@onready var cano: Marker2D = $Marker2D
@onready var cano_sprite = $Sprite2D
@onready var recarregar = $Relouding
var escala_inicial: Vector2
var contagem_balas = 0
var recarregando = false

func _ready() -> void:
	escala_inicial = scale

func _process(_delta: float) -> void:
	look_at(get_global_mouse_position())

	rotation_degrees = wrap(rotation_degrees, 0, 360)

	if rotation_degrees > 90 and rotation_degrees < 270:
		scale = Vector2(escala_inicial.x, -escala_inicial.y)
	else:
		scale = escala_inicial

	if Input.is_action_just_pressed("atirar") && recarregando == false:
		var instancia_bala = BALA.instantiate()
		get_tree().root.add_child(instancia_bala)
		instancia_bala.global_position = cano.global_position
		instancia_bala.global_rotation = global_rotation
		contagem_balas = contagem_balas + 1
		if contagem_balas >= 6:
			contagem_balas = 0
			cano_sprite.hide()
			recarregar.show()
			recarregando = true
			print(recarregando)
			await get_tree().create_timer(5.0).timeout
			recarregar.hide()
			cano_sprite.show()
			recarregando = false
			print(recarregando)	
