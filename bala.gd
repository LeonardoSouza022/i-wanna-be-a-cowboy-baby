extends Area2D

@export var velocidade: float = 500.0

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _process(delta: float) -> void:
	global_position += Vector2.RIGHT.rotated(global_rotation) * velocidade * delta

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		body.queue_free()
		ScoreManager.add_enemy_score()
		queue_free()
