extends Node

enum Weapon {
	SHOTGUN,
	RAYGUN,
}

@export var shotgun: Shotgun;
@export var raygun: Raygun;

@export var animation_duration: float = 3;

var current_weapon: Weapon;
var is_animating: bool = false;

func _ready():
	toogle(Weapon.SHOTGUN);

func _input(event):
	if event.is_action_pressed("scroll") && !is_animating:
		print("Weapon changed");
		toogle(current_weapon);


func toogle(current):
	match current:
		Weapon.SHOTGUN:
			switchWeapon(shotgun, raygun);
			current_weapon = Weapon.RAYGUN;
		Weapon.RAYGUN:
			switchWeapon(raygun, shotgun);
			current_weapon = Weapon.SHOTGUN;

func switchWeapon(equiped_weapon, next_weapon):
	is_animating = true;
	var tween = create_tween();
	tween.tween_property(equiped_weapon, "position:y", -1, animation_duration/2);
	tween.tween_callback(equiped_weapon.deactivate);
	var chain = tween.chain();
	chain.tween_callback(next_weapon.activate);
	chain.tween_property(next_weapon, "position:y", -0.6, animation_duration/2);
	tween.connect("finished", finish_animation);

func finish_animation():
	is_animating = false;
