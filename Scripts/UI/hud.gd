extends Node

@export var heat : Node;
@export var player : Node3D;

func _ready():
	var raygun = player.get_node("WeaponChange").raygun;
	
	heat.connect("on_heat_changed", func(val): $Heat.value = val);
	raygun.connect("on_ammo_changed", func(val): $Ammo.value = val);

	$Ammo.max_value = raygun.max_ammo;

