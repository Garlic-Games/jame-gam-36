extends CharacterBody3D

signal on_bullet_moai_collision;

@onready var particle: GPUParticles3D = $BulletSprite;

func _ready():
	particle.emitting = true;

	
func _physics_process(_delta):
	var collision = move_and_collide(velocity);

	if collision:
		var collider = collision.get_collider();
		if collider.is_in_group("moai"):
			var moai = collider as Moai;
			moai.moai_ouch();
			on_bullet_moai_collision.emit();
			
		print("bullet collided");
		queue_free();


func _on_bullet_sprite_finished():
	queue_free();
