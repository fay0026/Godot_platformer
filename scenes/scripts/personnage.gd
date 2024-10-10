extends CharacterBody2D

var HP = 9
signal health_changed
var lives = 3
signal lost_life
signal game_over

const SPEED = 100.0
const JUMP_VELOCITY = -375.0

func _on_spikes_ouch():
	HP -= 1
	if HP != 0 :
		health_changed.emit(HP);
	elif lives != 1:
		lives -= 1
		lost_life.emit(lives)
		print(position)
		print(global_position)
		to_global(Vector2(174, 119))
		HP = 9;
	else :
		lives = 3
		HP = 9
		game_over.emit()
		
func _on_death_instakill():
	if lives != 1:
		lives -= 1
		lost_life.emit(lives)
		print(position) 
		print(global_position)
		transform.origin = Vector2(174, 119)
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

func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		$AnimatedSprite2D.play("Raptor_walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$AnimatedSprite2D.stop()
	if direction == 1 :
		$AnimatedSprite2D.flip_h = false;
	if direction == -1 :
		$AnimatedSprite2D.flip_h = true;
		
	move_and_slide()
