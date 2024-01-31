extends Node3D

@export_group("Gun settings")
@export var ray_distance : float = 50.0;
@export var fire_units_per_tick : int = 1;
@export var time_between_ticks : float = 0.1;

var is_firing : bool = false;
var timer_gun : float = 0.0;

func _input(event):
	if event is InputEventMouseButton:
		if Input.is_action_just_pressed("fire"):
			is_firing = true;
		elif Input.is_action_just_released("fire"):
			is_firing = false;


func _process(delta):
	timer_gun += delta;
	
	if is_firing and timer_gun >= time_between_ticks:
		timer_gun = 0.0;
		detect_entity_in_sight();


func detect_entity_in_sight() -> void:
	var ray = PhysicsRayQueryParameters3D.create($PlayerCamera.global_position, $PlayerCamera.global_position - $PlayerCamera.global_transform.basis.z * ray_distance);
	var collision = get_world_3d().direct_space_state.intersect_ray(ray);
	
	if collision:
		if collision.collider.is_in_group("bird"):
			collision.collider.get_parent().add_fire(fire_units_per_tick);
