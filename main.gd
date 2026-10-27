extends Node2D

@onready var score_label: Label = $HUD/ScoreLabel
@onready var speech_bubble: Control = $HUD/SpeechBubble
@onready var phrase_label: Label = $HUD/SpeechBubble/Visuals/Bubble/Phrase
@onready var player_anchor: Node2D = $Player/AnimatedSprite2D

var phrase_time_left := 0.0
const SPEECH_BUBBLE_OFFSET := Vector2(0, -250)

func _ready() -> void:
	ScoreManager.reset()
	phrase_time_left = 0.0
	speech_bubble.hide()
	ScoreManager.score_changed.connect(_on_score_changed)
	ScoreManager.phrase_triggered.connect(_on_phrase_triggered)
	_on_score_changed(ScoreManager.score)

func _process(delta: float) -> void:
	_update_speech_bubble_position()

	if phrase_time_left <= 0.0:
		return

	phrase_time_left -= delta
	if phrase_time_left <= 0.0:
		speech_bubble.hide()

func _update_speech_bubble_position() -> void:
	var screen_position: Vector2 = get_viewport().get_canvas_transform() * player_anchor.global_position
	speech_bubble.position = screen_position + SPEECH_BUBBLE_OFFSET

func _on_score_changed(new_score: int) -> void:
	score_label.text = "Pontuação: %d" % new_score

func _on_phrase_triggered(phrase: String, _milestone: int) -> void:
	phrase_label.text = "Bebê Cowboy: \"%s\"" % phrase
	speech_bubble.show()
	phrase_time_left = 5.0
