class_name Bird
extends Node

@export var max_heat : int = 1000;

var current_heat : int = 0;


func _ready():
	for bird in  $"../Birds".get_children():
		bird.connect("on_bird_heat_changed", func(val): add_heat(val));


func _process(delta):
	if (current_heat >= max_heat):
		pass;


func add_heat(heat_units : int):
	current_heat = max(current_heat + heat_units, 0);
