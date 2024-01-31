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
@onready var hook_point: RayCast3D = $HookPoint;

signal launching_hook();
signal hooked();

var state : STATE = STATE.IDLE;
var origin_hook_point: Vector3;
var hooked_target: Vector3;

func _ready():
	origin_hook_point = hook_point.position;

func _input(event):
	if event is InputEventMouseButton and event.is_action_pressed("hook"):
		hook();

func hook():
	if state == STATE.IDLE:
		emit_signal("launching_hook");
		state = STATE.LAUNCHING;

func _physics_process(delta):
	match(state):
		STATE.RETRIEVING:
			move_hook(hook_speed * delta, to_global(origin_hook_point), STATE.IDLE);
		STATE.LAUNCHING:
			if hook_point.is_colliding():
				process_collission(hook_point.get_collision_point());
			else:
				move_hook(hook_speed * delta, hook_target.global_position, STATE.RETRIEVING);
		STATE.PULLING:
			move_towards_hook(hook_speed * delta, hooked_target);

		
func process_collission(collission_position: Vector3):
	emit_signal("hooked");
	hooked_target = collission_position;
	state = STATE.PULLING;


func move_towards_hook(speed: float, target: Vector3):
	hook_holder.global_position = lerp(hook_holder.global_position, target, speed);
	if hook_holder.global_position.distance_to(target) <= hook_treshold:
		state = STATE.RETRIEVING;

func move_hook(speed: float, target: Vector3, next_state: STATE) -> void:
	hook_point.global_position = lerp(hook_point.global_position, target, speed);
	if hook_point.global_position.is_equal_approx(target):
		state = next_state;
		
