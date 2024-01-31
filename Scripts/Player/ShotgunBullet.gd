extends CharacterBody3D


@onready var particle: GPUParticles3D = $BulletSprite;

func _ready():
	particle.emitting = true;

func _physics_process(delta):
	var collision = move_and_collide(velocity);
	if collision:
		print("bullet collided");
		queue_free();


func _on_bullet_sprite_finished():
	queue_free();
