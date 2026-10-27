extends Node

signal score_changed(new_score: int)
signal phrase_triggered(phrase: String, milestone: int)

const TIME_POINTS_INTERVAL := 1.0
const TIME_POINTS := 1
const ENEMY_POINTS := 10
const PHRASES := [
	"GUGU DADA! (EU VOU TE MATAR!)",
	"[PLACEHOLDER 2]",
	"[PLACEHOLDER 3]",
	"[PLACEHOLDER 4]",
	"[PLACEHOLDER 5]",
	"[PLACEHOLDER 6]",
	"[PLACEHOLDER 7]",
	"[PLACEHOLDER 8]",
	"[PLACEHOLDER 9]",
	"[PLACEHOLDER 10]"
]

var score := 0
var _time_accumulator := 0.0
var _next_phrase_score := 100
var _phrase_count := 0

func reset() -> void:
	score = 0
	_time_accumulator = 0.0
	_next_phrase_score = 100
	_phrase_count = 0

func _process(delta: float) -> void:
	_time_accumulator += delta
	while _time_accumulator >= TIME_POINTS_INTERVAL:
		_time_accumulator -= TIME_POINTS_INTERVAL
		add_score(TIME_POINTS)

func add_enemy_score() -> void:
	add_score(ENEMY_POINTS)

func add_score(points: int) -> void:
	if points <= 0:
		return

	var previous_score := score
	score += points
	score_changed.emit(score)

	while score >= _next_phrase_score and previous_score < _next_phrase_score:
		_trigger_phrase(_next_phrase_score)
		_next_phrase_score *= 2

func _trigger_phrase(milestone_score: int) -> void:
	var phrase: String = PHRASES[_phrase_count % PHRASES.size()]
	_phrase_count += 1
	phrase_triggered.emit(phrase, milestone_score)
