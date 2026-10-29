extends Sprite2D

@export var speed := 150.0
@export var padding := 64.0
var fundo_noite = load("res://Sprites/western_background_midnight_tamanho_certo.png")
var fundo_dia = load("res://western_background.png")
func _process(delta: float) -> void:
	var camera: Camera2D = get_viewport().get_camera_2d()
	if camera == null:
		return
	

	var visible_size: Vector2 = get_viewport_rect().size / camera.zoom
	global_position = camera.global_position
	region_rect.size = visible_size + Vector2(padding * 2.0, padding * 2.0)
	region_rect.position.x += speed * delta
func _ready() -> void:
	mudancaFundo()
	
func mudancaFundo() -> void:
	while true:
		await get_tree().create_timer(5.0).timeout
		self.texture = fundo_noite

		await get_tree().create_timer(5.0).timeout
		self.texture = fundo_dia
