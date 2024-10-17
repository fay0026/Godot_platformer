extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 25.0
var direction := 1

func defeated() -> void :
	queue_free()

func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if not $RayCast2D3.is_colliding():
		if direction == 1 :
			direction = -1
		else :
			direction = 1
			
	if $RayCast2D.is_colliding():
		direction = -1
			
	if $RayCast2D2.is_colliding():
		direction = 1 
			
	if direction:
		velocity.x = direction * SPEED
		$AnimatedSprite2D.play("default")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$AnimatedSprite2D.stop()
		
	if direction == 1 :
		$AnimatedSprite2D.flip_h = false;
	if direction == -1 :
		$AnimatedSprite2D.flip_h = true;

	move_and_slide()
