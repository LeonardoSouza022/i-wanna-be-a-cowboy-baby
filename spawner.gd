
extends Node2D

@onready var spawn_timer = $SpawnTimer
@onready var spawn_point = $Marker2D

var enemies_scene = [
	preload("res://inimigo_1.tscn"),
	preload("res://inimigo_2.tscn")
]

func _ready() -> void:
	randomize()
	spawn_timer.timeout.connect(spawn_enemies)
	start_spawn_timer()

func spawn_enemies() -> void:
	var random_enemy = enemies_scene.pick_random()
	var enemy = random_enemy.instantiate()
	add_child(enemy)

	var camera = get_viewport().get_camera_2d()
	var screen_size = get_viewport_rect().size
	var world_width = screen_size.x * camera.zoom.x

	enemy.global_position.x = camera.get_screen_center_position().x + world_width / 2 + 50
	enemy.global_position.y = spawn_point.global_position.y
	
	start_spawn_timer()

func start_spawn_timer() -> void:
	spawn_timer.wait_time = randf_range(2.0, 4.5)
	spawn_timer.start()
