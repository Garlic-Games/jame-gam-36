extends Node

signal on_bird_heat_changed;

@export var max_fire_units : int = 100;
@export var heat_decay : int = 2;
@export var heat_decay_period : float = 1.0;
@export var time_to_start_cooling : float = 2.0;
@export var animation_max_speed : float = 12.0;

var current_fire_units : int = 0;
var is_alive = true;

var timer_heat_decay = 0.0;
var timer_cooling = 0.0;


func _ready():
	$AnimationPlayer.play("fly");
	$AnimationPlayer.seek(randf_range(0.0, $AnimationPlayer.current_animation_length));


func _process(delta):
	if is_alive:
		timer_heat_decay += delta;
		timer_cooling += delta;

		if timer_cooling >= time_to_start_cooling:
			if timer_heat_decay >= heat_decay_period:
				timer_heat_decay = 0.0;
				add_fire(-heat_decay);

		if current_fire_units >= max_fire_units:
			kill();


func add_fire(fire_units : int):
	current_fire_units += fire_units;
	
	if current_fire_units < 0:
		current_fire_units = 0;
	else:
		on_bird_heat_changed.emit(fire_units);
		
	$SubViewport/ProgressBar.value = current_fire_units;
	
	$AnimationPlayer.speed_scale = (animation_max_speed - 1.0) / max_fire_units * current_fire_units + 1.0;

	timer_cooling = 0.0;


func kill():
	is_alive = false;
	self.queue_free();
