extends Node3D
class_name Raygun;

signal on_ammo_changed;

@export_group("Weapon settings")
@export var max_ammo : int = 150;
@export var starting_ammo : int = 100;
@export var ray_distance : float = 50.0;
@export var fire_units_per_tick : int = 1;
@export var time_between_ticks : float = 0.1;

var current_ammo : int = 0;
var is_firing : bool = false;
var timer_gun : float = 0.0;
var is_active = true;

func _input(event):
	if !is_active:
		return;
		
	if event is InputEventMouseButton:
		if Input.is_action_just_pressed("fire"):
			is_firing = true;
		elif Input.is_action_just_released("fire"):
			is_firing = false;


func _ready():
	current_ammo = starting_ammo;


func _process(delta):
	if !is_active:
		return;

	if is_firing:
		timer_gun += delta;
		
		if current_ammo > 0 and timer_gun >= time_between_ticks:
			timer_gun = 0.0;
			shoot();

	else:
		timer_gun = time_between_ticks;


func shoot():
	detect_entity_in_sight();
	current_ammo -= 1;
	on_ammo_changed.emit(current_ammo);
	print(current_ammo)

func detect_entity_in_sight():
	var ray = PhysicsRayQueryParameters3D.create(get_parent().global_position, get_parent().global_position - get_parent().global_transform.basis.z * ray_distance);
	var collision = get_world_3d().direct_space_state.intersect_ray(ray);
	
	if collision:
		if collision.collider.is_in_group("bird"):
			collision.collider.get_parent().add_fire(fire_units_per_tick);

func activate():
	show();
	is_active = true;
	
func deactivate():
	hide();
	is_active = false;
