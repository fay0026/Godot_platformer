extends CanvasLayer

@onready var lives: Label = $Control/BoxContainer3/Label
@onready var diamonds: Label = $Control/BoxContainer/Label
@onready var health: TextureProgressBar = $Control/hp_bar/TextureProgressBar

var diamonds_total = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health.value=9

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_personnage_health_changed(HP) -> void:
	health.value = HP

func _on_personnage_lost_life(lives_left) -> void:
	health.value = 9
	lives.text = str(lives_left)
	
func _on_diamant_diamond(value) -> void:
	diamonds_total += value
	diamonds.text = str(diamonds_total)
