extends Node3D

enum STATE {
	IDLE,
	LAUNCHING,
	RETRIEVING,
	PULLING
}

@export var hook_speed: float = 0.5;
@export var hook_treshold: float = 0.5;
@export var hook_target: Node3D;
@export var hook_holder: Node3D;
@onready var hook_point_scene: PackedScene = preload("res://Prefabs/Player/hook_point.tscn");
@onready var hook_point: CharacterBody3D;

signal launching_hook();
signal hooked();

var state : STATE = STATE.IDLE;
var hooked_target: Vector3;


func _input(event):
	if event is InputEventMouseButton and event.is_action_pressed("hook"):
		hook();

func hook():
	if state == STATE.IDLE:
		hook_point = hook_point_scene.instantiate();
		$"/root/".add_child(hook_point);
		hook_point.global_position = global_position;
		hook_point.global_rotation = global_rotation;
		emit_signal("launching_hook");
		state = STATE.LAUNCHING;

func _physics_process(delta):
	match(state):
		STATE.RETRIEVING:
			move_hook(hook_speed * delta, global_position);
			if hook_point.global_position.distance_to(global_position) <= hook_treshold:
				go_idle();
		STATE.LAUNCHING:
			var colission = move_hook(hook_speed * delta, hook_target.global_position);
			if colission:
				emit_signal("hooked");
				hooked_target = colission.get_position();
				state = STATE.PULLING;
			elif hook_point.global_position.distance_to(hook_target.global_position) <= hook_treshold:
				hook_point.collision_mask = 0;
				state = STATE.RETRIEVING;
		STATE.PULLING:
			move_towards_hook(hook_speed * delta, hooked_target);



func move_towards_hook(speed: float, target: Vector3):
	hook_holder.global_position = lerp(hook_holder.global_position, target, speed);
	if hook_holder.global_position.distance_to(target) <= hook_treshold:
		state = STATE.RETRIEVING;

func move_hook(speed: float, target: Vector3) ->  KinematicCollision3D:
	var direction = hook_point.global_position.direction_to(target);
	var colission = hook_point.move_and_collide(direction * speed);
	if colission:
		return colission;
	return null;

func go_idle():
	hook_point.queue_free();
	state = STATE.IDLE;
