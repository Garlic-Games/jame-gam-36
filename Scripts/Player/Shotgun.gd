extends Node3D
class_name Shotgun;

@export var forward: Node3D;
@export var bullet_speed: float = 1;
@onready var bulletHole: Node3D = $BulletHole;
@onready var bullet: PackedScene = preload("res://Prefabs/Player/shotgun_bullet.tscn");
@onready var random: RandomNumberGenerator = RandomNumberGenerator.new();
var is_active = true;

func _input(event):
	if !is_active:
		return;
	if event is InputEventMouseButton and event.is_action_pressed("fire"):
		shoot();

func shoot():
	var instance = bullet.instantiate(); 
	$"/root/".add_child(instance);
	instance.connect("on_bullet_moai_collision", $"../../WeaponChange".raygun.recharge_ammo);
	instance.global_position = bulletHole.global_position; 
	instance.global_rotation = bulletHole.global_rotation;
	instance.velocity = bulletHole.global_position.direction_to(forward.global_position) * bullet_speed; 

func activate():
	show();
	is_active = true;
	
func deactivate():
	hide();
	is_active = false;
