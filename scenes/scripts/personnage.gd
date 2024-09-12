extends Node2D

var HP = 9
signal health_changed
var lives = 3
signal lost_life
signal game_over

func _on_spikes_ouch():
	HP -= 1
	if HP != 0 :
		health_changed.emit(HP);
	elif lives != 1:
		lives -= 1
		lost_life.emit(lives)
		HP = 9;
	else :
		lives = 3
		HP = 9
		game_over.emit()
		
func _on_death_watabebad():
	if lives != 1:
		lives -= 1
		lost_life.emit(lives)
		HP = 9;
	else :
		lives = 3
		HP = 9
		game_over.emit()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
