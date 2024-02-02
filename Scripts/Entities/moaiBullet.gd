class_name MoaiSmoke
extends CharacterBody3D

signal on_moai_bullet_collided;
signal on_moai_bullet_hit_player;
var impulse_strength: float = 10;

@onready var particle: GPUParticles3D = $BulletSprite;

func _ready():
	particle.emitting = true;

	
func _physics_process(_delta):
	var collision = move_and_collide(velocity);

	if collision:
		var collider = collision.get_collider();
		if collider.is_in_group("Player"):
			var player = collider as Player;
			player.velocity += velocity.normalized() * impulse_strength;
			player.ouch();			
			
		on_moai_bullet_collided.emit();
		print("bullet collided");
		queue_free();

func _on_bullet_sprite_finished():
	queue_free();
