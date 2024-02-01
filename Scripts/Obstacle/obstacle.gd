extends Node

signal on_obstacle_cleared;

@export var heat_threshold = 100;


func disable():
	on_obstacle_cleared.emit();
	self.queue_free();
