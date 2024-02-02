extends Node3D

signal on_bird_heat_changed(heat: float);

@export_group("Main menu settings")
@export var main_menu_mode : bool = false;
@export var animation_speed : float = 1.0;

@export_group("Gameplay settings")
@export var max_fire_units : int = 100;
@export var heat_decay : int = 5;
@export var heat_decay_period : float = 1.0;
@export var time_to_start_cooling : float = 2.0;
@export var animation_max_speed : float = 12.0;
@export var waypointGroup: PathWaypointGroup;
@export var Speed: float = 2.5;

@onready var birdfire: GPUParticles3D = $birdFire;
@onready var explosion: GPUParticles3D = $explode;
@onready var explosionSmoke: GPUParticles3D = $explosionSmoke;
@onready var armature: Node3D = $Armature;

var current_fire_units : int = 0;
var is_alive = true;

var timer_heat_decay = 0.0;
var timer_cooling = 0.0;


var _seekNode: Node3D = null;
var _lastDistance: float = 999999.9;
var _moving: bool = false;

func _ready():
	$AnimationPlayer.play("fly");
	
	if main_menu_mode:
		$SubViewport/ProgressBar.hide();
		$AnimationPlayer.speed_scale = animation_speed;
	else:
		$AnimationPlayer.seek(randf_range(0.0, $AnimationPlayer.current_animation_length));


func _process(delta):
	if main_menu_mode:
		return;
		
	if is_alive:
		timer_heat_decay += delta;
		timer_cooling += delta;

		if timer_cooling >= time_to_start_cooling:
			if timer_heat_decay >= heat_decay_period:
				timer_heat_decay = 0.0;
				add_fire(-heat_decay);

		if current_fire_units >= max_fire_units:
			kill();

func _physics_process(delta):
	if main_menu_mode:
		return;
		
	if (!waypointGroup):
		printerr("No waypoint group set for ", self)
		return;
	if _seekNode == null:
		_nextPath();
	if _moving:
		translate(Vector3.FORWARD * Speed * delta);
		
	var  newDistance = global_position.distance_to(_seekNode.global_position);
	if newDistance > _lastDistance:
		_moving = false;
		_nextPath()
	else:
		_lastDistance = newDistance;
		
	
func _nextPath():
	if !waypointGroup:
		return;
	_seekNode = waypointGroup.getRandomNode();
	_lastDistance = global_position.distance_to(_seekNode.global_position);
	look_at(_seekNode.global_position)
	_moving = true;


func add_fire(fire_units : int):
	current_fire_units += fire_units;

	if current_fire_units < 0:
		current_fire_units = 0;
		birdfire.emitting = false;
		birdfire.amount = 1;
	else:
		on_bird_heat_changed.emit(fire_units);
		birdfire.emitting = true;
		birdfire.amount = (current_fire_units if current_fire_units > 0  else 1);

		
	$SubViewport/ProgressBar.value = current_fire_units;
	
	$AnimationPlayer.speed_scale = (animation_max_speed - 1.0) / max_fire_units * current_fire_units + 1.0;

	timer_cooling = 0.0;


func kill():
	is_alive = false;
	explode();

func explode():
	explosion.emitting = true;
	explosionSmoke.emitting = true;

func _on_explode_finished():
	self.queue_free();
