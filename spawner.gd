
extends Node2D

@onready var spawn_timer = $SpawnTimer
@onready var flying_spawn_timer = $FlyingSpawnTimer
@onready var spawn_point = $GroundSpawnPoint
@onready var flying_spawn_point = $FlyingSpawnPoint

var ground_enemies_scene = [
	preload("res://inimigo_1.tscn"),
	preload("res://inimigo_2.tscn")
]

var flying_enemies_scene = [
	preload("res://inimigo_voador_1.tscn"),
	preload("res://inimigo_voador_2.tscn")
]

func _ready() -> void:
	randomize()
	spawn_timer.timeout.connect(spawn_enemies)
	flying_spawn_timer.timeout.connect(spawn_flying_enemies)
	start_spawn_timer()
	start_flying_spawn_timer()

func spawn_enemies() -> void:
	var random_enemy = ground_enemies_scene.pick_random()
	var enemy = random_enemy.instantiate()
	add_child(enemy)

	enemy.global_position.x = get_spawn_x()
	enemy.global_position.y = spawn_point.global_position.y

	start_spawn_timer()

func spawn_flying_enemies() -> void:
	var random_enemy = flying_enemies_scene.pick_random()
	var enemy = random_enemy.instantiate()
	add_child(enemy)

	enemy.global_position.x = get_spawn_x()
	var variacaoIni = randf_range(2.0, 4.5)
	enemy.global_position.y = flying_spawn_point.global_position.y + variacaoIni

	start_flying_spawn_timer()

func start_spawn_timer() -> void:
	spawn_timer.wait_time = randf_range(2.0, 4.5)
	spawn_timer.start()

func start_flying_spawn_timer() -> void:
	flying_spawn_timer.wait_time = randf_range(2.5, 5.0)
	flying_spawn_timer.start()

func get_spawn_x() -> float:
	var camera = get_viewport().get_camera_2d()
	var screen_size = get_viewport_rect().size
	var world_width = screen_size.x * camera.zoom.x
	return camera.get_screen_center_position().x + world_width / 2 + 50
