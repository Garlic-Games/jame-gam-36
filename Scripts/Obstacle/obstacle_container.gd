extends Node

var obstacles : Array[Node] = [];

func _ready():
	obstacles = get_children();
	
	$"../Heat".connect("on_heat_changed", func(val): check_obstacles(val));


func check_obstacles(current_heat):
	for obstacle in obstacles:
		if current_heat >= obstacle.heat_threshold:
			obstacle.disable();
			obstacles.erase(obstacle);
