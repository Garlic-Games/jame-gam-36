extends Node

signal on_bird_heat_changed;

@export var max_fire_units : int = 100;
@export var heat_decay : int = 2;
@export var heat_decay_period : float = 1.0;

var current_fire_units : int = 0;
var timer_heat_decay = 0.0;
var is_alive = true;


func _process(delta):
	if is_alive:
		timer_heat_decay += delta;
		
		if timer_heat_decay >= heat_decay_period:
			timer_heat_decay = 0.0;
			add_fire(-heat_decay);

		if current_fire_units >= max_fire_units:
			kill();


func add_fire(fire_units : int):
	current_fire_units += fire_units;
	on_bird_heat_changed.emit(fire_units);


func kill():
	is_alive = false;
	self.queue_free();
