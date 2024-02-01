extends Node

signal on_heat_changed;

@export var max_heat : int = 1000;
@export var birds : Node = null;

var current_heat : int = 0;
var gameplay_manager : GameplayManager = null;

func _ready():
	if get_parent() is GameplayManager:
		gameplay_manager = get_parent();
		
	for bird in birds.get_children():
		print(bird)
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
