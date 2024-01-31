extends Node3D;

class_name Portal;

@export var exit: Portal;
var just_teleported: bool = false;
func _on_portal_entered(body):
	if just_teleported:
		return;
	exit.just_teleported = true;
	body.global_position = exit.global_position;

func _on_portal_exited(body):
	exit.just_teleported = false;
