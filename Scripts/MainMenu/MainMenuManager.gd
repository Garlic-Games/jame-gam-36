extends Node3D

@export var click_audio : AudioStreamPlayer = null;


func _ready():
	$Transitions/TransitionFadeIn/Animation.play("fade_in");


func _on_start_game_pressed():
	click_audio.play();
	StartGame()


func StartGame():
	GameStateMachine.changeState(GameStateMachine.GAME_STATE.PLAYING);
	
func _on_settings_pressed():
	click_audio.play();
	pass;


func _on_credits_pressed():
	click_audio.play();
	pass;


func _on_exit_pressed():
	click_audio.play();
	get_tree().quit();


func _on_start_game_mouse_entered():
	click_audio.play();


func _on_settings_mouse_entered():
	click_audio.play();


func _on_credits_mouse_entered():
	click_audio.play();


func _on_exit_mouse_entered():
	click_audio.play();
