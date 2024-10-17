extends CanvasLayer

@onready var yourScore: Label = $Control/yourScore
@onready var bestScore: Label = $Control/bestScore

var config = ConfigFile.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()

func _on_give_up_pressed() -> void:
	get_tree().quit()

func _on_gui_game_over(score) -> void:
	visible = true
	var scores = config.load("cfg")
	if (config.get_value('Score', 'best')):
		if (config.get_value('Score', 'best') < score) :
			config.set_value('Score', 'best', score)
	else :
		config.set_value('Score', 'best', score)
	yourScore.text = str(score)
	bestScore.text = str(config.get_value('Score', 'best'))
	config.save('cfg')
