extends CharacterBody2D

var damageTimeout = 0.5
var ennemyTimeout = 0.1
var HP = 9
signal health_changed
var lives = 3
signal lost_life
signal game_over
signal ennemy_collided
signal ennemy_defeated

const SPEED = 100.0
const JUMP_VELOCITY = -375.0

func damage_taken(damage):
	HP -= damage
	if HP > 0 :
		health_changed.emit(HP);
	elif lives != 1:
		transform.origin = Vector2(174, 119)
		lives -= 1
		lost_life.emit(lives)
		HP = 9;
	else :
		transform.origin = Vector2(1000, 1000)
		lives = 3
		HP = 9
		game_over.emit()

func _on_spikes_ouch():
	damage_taken(1)
		
func _on_death_instakill():
	if lives != 1:
		transform.origin = Vector2(174, 119)
		lives -= 1
		lost_life.emit(lives)
		HP = 9;
	else :
		transform.origin = Vector2(1000, 1000)
		lives = 3
		HP = 9
		game_over.emit()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

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
	
	damageTimeout -= delta
	ennemyTimeout -= delta
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if (collision.get_collider().name.substr(0, 11) == 'Ennemy_tscn') :
			if (collision.get_normal().dot(Vector2.UP) > 0.5):
				if (ennemyTimeout <= 0):
					collision.get_collider().call('defeated')
					ennemy_defeated.emit()
					ennemyTimeout = 0.1
			else :
				if (damageTimeout <= 0):
					damage_taken(2)
					damageTimeout = 0.5
