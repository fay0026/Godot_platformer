extends Area2D
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	gpu_particles_2d.emitting = true
	await get_tree().create_timer(1.2).timeout
	queue_free()
