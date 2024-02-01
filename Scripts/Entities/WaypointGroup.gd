extends Node3D

class_name PathWaypointGroup;


var pathPoints: Array[Node3D] = [];

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		pathPoints.append(child);

func getRandomNode():
	var i = roundi(randf() * pathPoints.size() -1);
	return pathPoints[i];
