extends StaticBody3D

@export var heat : Node = null;
@export var heat_threshold : int = 100;
@export var desired_collision_layer : int = 1;

func _ready():
	hide();
	heat.connect("on_heat_changed", spawn_item);
	collision_layer = 0;

func spawn_item():
	if heat_threshold > heat.current_heat:
		show();
		collision_layer = desired_collision_layer;
