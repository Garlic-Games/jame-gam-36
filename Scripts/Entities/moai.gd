class_name  Moai;
extends StaticBody3D;

@export var target: Node3D;
@export var rotation_speed: float = 2;

@export_group("Floating animation")
@export var floating_amplitude : float = 0.25;
@export var floating_period : float = 3.0;
@export var obstacles : Node = null;
@export var waypoints : Node = null;
@export_group("Shooting options")
@export var shoot_treshold: float = 0.1;
@export var bullet_speed: float = 2;
@export var shoot_period : float = 3.0;
@export var impulse_strenght : float = 10.0;

@onready var bullet: PackedScene = preload("res://Prefabs/Entities/moai_smoke.tscn");
const FLOOR_MASK = 1; # also the floor mask
const PLAYER_MASK = 2; # also the floor mask

var initial_position_y : float;

var positions : Array[Vector3] = [];
var waypoint_index : int = 0;
var timer_floating : float = 0.0;
var timer_shoot: float = shoot_period;

signal bullet_shot;
signal ouch;

func _ready():
	if obstacles && waypoints:
		for obstacle in obstacles.get_children():
			obstacle.connect("on_obstacle_cleared", go_next_waypoint);
		for waypoint in waypoints.get_children():
			positions.append(waypoint.position);

		waypoint_index = 0;
			
		position = positions[0];
	initial_position_y = position.y;


func _process(delta):
	float_animation(delta);
	timer_shoot += delta;
	
	if !target || is_there_a_wall():
		return;
		
	rotate_towards_target(delta);
	
	if timer_shoot >= shoot_period:
		if check_if_facing(target.global_position, shoot_treshold):
			timer_shoot = 0;
			shoot(target);

func check_if_facing(_target: Vector3, threshold: float) -> bool: 
	var dir = global_position.direction_to(_target);
	var product = dir.dot(basis.z.normalized());
	return  product > threshold;

func rotate_towards_target(delta: float) -> void:
	var direction = global_position.direction_to(target.position);
	var next_rotation = atan2(-direction.x, -direction.z)+90;
	rotation.y = lerp_angle(rotation.y, next_rotation, delta * rotation_speed);

func is_there_a_wall() -> bool:
	var ray = PhysicsRayQueryParameters3D.create(global_position, target.global_position, FLOOR_MASK);
	var collision = get_world_3d().direct_space_state.intersect_ray(ray);
	return !collision.is_empty();

func float_animation(delta: float) -> void:
	timer_floating += delta;
	if timer_floating > floating_period:
		timer_floating -= floating_period;
	position.y = initial_position_y + floating_amplitude * sin(2.0 * PI / floating_period * timer_floating);

func shoot(current_target):
	var instance = bullet.instantiate() as MoaiSmoke; 
	$"/root/".add_child(instance);
	instance.global_position = global_position; 
	instance.global_rotation = global_rotation;
	instance.velocity = global_position.direction_to(current_target.global_position) * bullet_speed; 
	instance.impulse_strength = impulse_strenght;
	bullet_shot.emit();


func go_next_waypoint():
	if waypoint_index + 1 < positions.size():
		waypoint_index += 1;
		position = positions[waypoint_index];
		initial_position_y = position.y;


func _on_sight_area_body_entered(body):
	target = body;


func _on_sight_area_body_exited(_body):
	target = null;

func moai_ouch():
	ouch.emit();
