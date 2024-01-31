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
	var instance = bullet.instantiate(); #unpacks the scene that is loaded in the preload function
	$"/root/".add_child(instance); #adds child to the 3d world
	instance.global_position = bulletHole.global_position; #set whatever position you need
	instance.velocity = (forward.global_position - instance.global_position) * bullet_speed; #direction you want it to fire in
