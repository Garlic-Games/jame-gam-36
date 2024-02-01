extends Node3D

@export var click_audio : AudioStreamPlayer = null;
@export var camera : Camera3D = null;
@export var camera_waypoints : Node = null;

var waypoints_transforms : Array[Transform3D] = [];


func _ready():
	$Transitions/Fade/Animation.play("fade_in");

	for node in camera_waypoints.get_children():
		waypoints_transforms.append(node.global_transform);

	camera.transform = waypoints_transforms[0];


func _on_start_game_pressed():
	click_audio.play();
	$Transitions/Fade/Animation.play("fade_out");
	$Transitions/Fade/Animation.connect("animation_finished", func(_val): StartGame());


func StartGame():
	GameStateMachine.changeState(GameStateMachine.GAME_STATE.PLAYING);


func _on_settings_pressed():
	click_audio.play();
	$Menu/Main.hide();
	$Menu/Settings.show();

	var tween_transform = get_tree().create_tween();
	tween_transform.tween_property(camera, "transform", waypoints_transforms[1], 1.5);
	
	var tween_zoom = get_tree().create_tween();
	tween_zoom.tween_property(camera, "size", 0.6, 1.5);
	
func _on_credits_pressed():
	click_audio.play();
	$Menu/Main.hide();
	$Menu/Credits.show();

	var tween_transform = get_tree().create_tween();
	tween_transform.tween_property(camera, "transform", waypoints_transforms[2], 1.5);
	var tween_zoom = get_tree().create_tween();
	tween_zoom.tween_property(camera, "size", 0.3, 1.5);
	
func _on_exit_pressed():
	click_audio.play();
	get_tree().quit();


func on_button_hovered():
	click_audio.play();


func _on_back_pressed():
	var tween_transform = get_tree().create_tween();
	tween_transform.tween_property(camera, "transform", waypoints_transforms[0], 1.5);
	
	var tween_zoom = get_tree().create_tween();
	tween_zoom.tween_property(camera, "size", 1, 1.5);
