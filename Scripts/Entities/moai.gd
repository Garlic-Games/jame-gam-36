extends Node3D

@export var target: Node3D;
@export var rotation_speed: float = 2;
@export var fire_treshold: float = 10;
@export var bullet_speed: float = 2;
@onready var bullet: PackedScene = preload("res://Prefabs/Entities/moai_smoke.tscn");
const PLAYER_MASK = 2;



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !target:
		return;
		
	var ray = PhysicsRayQueryParameters3D.create(global_position, target.global_position, PLAYER_MASK);
	var collision = get_world_3d().direct_space_state.intersect_ray(ray);
	if(!collision):
		return;
	var direction = global_position.direction_to(target.position);
	var next_rotation = atan2(-direction.x, -direction.z)+90;
	rotation.y = lerp_angle(rotation.y, next_rotation, delta * rotation_speed);
	if abs(next_rotation - rotation.y) <= fire_treshold:
		shoot(target);
		
func shoot(target):
	var instance = bullet.instantiate(); 
	$"/root/".add_child(instance);
	instance.global_position = global_position; 
	instance.global_rotation = global_rotation;
	instance.velocity = global_position.direction_to(target.global_position) * bullet_speed; 

func _on_sight_area_body_entered(body):
	target = body;


func _on_sight_area_body_exited(body):
	target = null;
