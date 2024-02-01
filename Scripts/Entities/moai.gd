extends Node3D

@export var target: Node3D;
@export var rotation_speed: float = 2;
@export var fire_treshold: float = 10;
@export var bullet_speed: float = 2;
@export var floating_amplitude : float = 0.25;
@export var floating_period : float = 3.0;
@export var obstacles : Node = null;
@export var waypoints : Node = null;

@onready var bullet: PackedScene = preload("res://Prefabs/Entities/moai_smoke.tscn");
const PLAYER_MASK = 2;

var initial_position_y : float;
var timer_floating : float = 0.0;

var positions : Array[Vector3] = [];
var waypoint_index : int = 0;

func _ready():
	for obstacle in obstacles.get_children():
		obstacle.connect("on_obstacle_cleared", go_next_waypoint);
		
	for waypoint in waypoints.get_children():
		positions.append(waypoint.position);

	waypoint_index = 0;
		
	position = positions[0];
	initial_position_y = position.y;


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

	timer_floating += delta;

	if timer_floating > floating_period:
		timer_floating -= floating_period;

	position.y = initial_position_y + floating_amplitude * sin(2.0 * PI / floating_period * timer_floating);


func shoot(current_target):
	var instance = bullet.instantiate(); 
	$"/root/".add_child(instance);
	instance.global_position = global_position; 
	instance.global_rotation = global_rotation;
	instance.velocity = global_position.direction_to(current_target.global_position) * bullet_speed; 


func go_next_waypoint():
	if waypoint_index + 1 < positions.size():
		waypoint_index += 1;
		position = positions[waypoint_index];


func _on_sight_area_body_entered(body):
	target = body;


func _on_sight_area_body_exited(_body):
	target = null;
