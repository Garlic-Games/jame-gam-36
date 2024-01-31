extends Node3D

@export var forward: Node3D;
@export var bullet_speed: float = 1;
@onready var bulletHole: Node3D = $BulletHole;
@onready var bullet: PackedScene = preload("res://Prefabs/Player/shotgun_bullet.tscn");
@onready var random: RandomNumberGenerator = RandomNumberGenerator.new();

func _input(event):
	if event is InputEventMouseButton and event.is_action_pressed("fire"):
		shoot();

func shoot():
	var instance = bullet.instantiate(); 
	$"/root/".add_child(instance);
	instance.global_position = bulletHole.global_position; 
	instance.global_rotation = bulletHole.global_rotation;
	instance.velocity = bulletHole.global_position.direction_to(forward.global_position) * bullet_speed; 
