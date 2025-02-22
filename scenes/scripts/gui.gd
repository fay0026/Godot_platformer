extends CanvasLayer

@onready var lives: Label = $Control/BoxContainer3/Label
@onready var diamonds: Label = $Control/BoxContainer/Label
@onready var health: TextureProgressBar = $Control/hp_bar/TextureProgressBar
@onready var score: Label = $Control/BoxContainer2/LabelScore

signal diamond(value)
signal game_over

var diamonds_total = 0
var score_var = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health.value=9

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_personnage_health_changed(HP) -> void:
	score_var -= 15
	health.value = HP
	score.text = str(score_var)

func _on_personnage_lost_life(lives_left) -> void:
	health.value = 9
	lives.text = str(lives_left)

func _on_personnage_ennemy_defeated() -> void:
	score_var += 50
	score.text = str(score_var)

func _on_personnage_game_over_get_score() -> void:
	game_over.emit(score_var)


func _on_diamond(value: Variant) -> void:
	diamonds_total += value
	score_var += value*100
	diamonds.text = str(diamonds_total)
	score.text = str(score_var)
