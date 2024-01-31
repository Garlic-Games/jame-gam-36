extends Node

@export var heat_threshold = 100;


func disable():
	self.queue_free();
