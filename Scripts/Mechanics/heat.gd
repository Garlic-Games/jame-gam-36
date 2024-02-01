extends Node

signal on_heat_changed;

@export var max_heat : int = 1000;

var current_heat : int = 0;
var gameplay_manager : GameplayManager = null;

func _ready():
	gameplay_manager = $"..";
	for bird in  $"../Birds".get_children():
		bird.connect("on_bird_heat_changed", func(val): add_heat(val));


func _process(_delta):
	if (current_heat >= max_heat):
		gameplay_manager.EndGame();


func add_heat(heat_units : int):
	current_heat += heat_units;
	
	if current_heat < 0:
		current_heat = 0;
	else:
		on_heat_changed.emit(current_heat);
