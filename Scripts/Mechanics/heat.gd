extends Node

signal on_heat_changed;
signal on_heat_filled;

@export var max_heat : int = 1000;
@export var birds : Node = null;

var is_heat_filled : bool = false;
var current_heat : int = 0;
var gameplay_manager : GameplayManager = null;

func _ready():
	if get_parent() is GameplayManager:
		gameplay_manager = get_parent();
		
	for bird in birds.get_children():
		print(bird)
		bird.connect("on_bird_heat_changed", func(val): add_heat(val));


func add_heat(heat_units : int):
	if not is_heat_filled:
		current_heat += heat_units;

		if current_heat < 0:
			current_heat = 0;
		elif current_heat >= max_heat:
			is_heat_filled = true;
			on_heat_filled.emit();
		else:
			on_heat_changed.emit(current_heat);
