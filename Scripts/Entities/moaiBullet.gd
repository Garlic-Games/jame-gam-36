extends CharacterBody3D

signal on_player_bullet_collision;

@onready var particle: GPUParticles3D = $BulletSprite;

func _ready():
	particle.emitting = true;

	
func _physics_process(_delta):
	var collision = move_and_collide(velocity);

	if collision:
		if collision.get_collider().is_in_group("moai"):
			on_player_bullet_collision.emit();
			
		print("bullet collided");
		queue_free();


func _on_bullet_sprite_finished():
	queue_free();