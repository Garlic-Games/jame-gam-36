extends Node

@export var duration : float = 1.0;


func _ready():
	$Animation.speed_scale = 1.0 / duration;
	$Animation.play("fade_in");
