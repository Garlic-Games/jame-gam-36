extends Camera3D

@export var mouse_sensitivity = .2;

@onready var player = get_parent();  

func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		player.rotation_degrees.y -= event.relative.x * mouse_sensitivity / 10;
		rotation_degrees.x = clamp(rotation_degrees.x - event.relative.y * mouse_sensitivity / 10, -90, 90);

