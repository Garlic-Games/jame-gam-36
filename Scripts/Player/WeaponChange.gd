extends Node

enum Weapon {
	SHOTGUN,
	RAYGUN,
}

@export var shotgun: Shotgun;
@export var raygun: Raygun;

@export var animation_duration: float = 3;

var current_weapon: Weapon;
var is_animating: bool;

func _ready():
	current_weapon = Weapon.RAYGUN;
	shotgun.deactivate();
	raygun.activate();

func _input(event):
	if event.is_action_pressed("scroll") && !is_animating:
		print("Weapon changed");
		match current_weapon:
			Weapon.SHOTGUN:
				switchWeapon(raygun, shotgun);
				current_weapon = Weapon.RAYGUN;
			Weapon.RAYGUN:
				switchWeapon(shotgun, raygun);
				current_weapon = Weapon.SHOTGUN;


func switchWeapon(equiped_weapon, next_weapon):
	is_animating = true;
	var tween = create_tween();
	tween.tween_callback(equiped_weapon.deactivate);
	tween.tween_property(equiped_weapon, "position:y", -0.7, animation_duration/2);
	var chain = tween.chain();
	chain.tween_callback(next_weapon.activate);
	chain.tween_property(next_weapon, "position:y", -0.6, animation_duration/2);
	tween.connect("finished", finish_animation);

func finish_animation():
	is_animating = false;
