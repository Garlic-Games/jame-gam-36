extends CanvasLayer

@export var click_audio : AudioStreamPlayer = null;
@export var text_fullscreen : Label = null;

var is_fullscreen : bool = false;
var is_paused : bool = false;


func _ready():
	hide();


func _input(event):
	if GameStateMachine.currentState == GameStateMachine.GAME_STATE.PLAYING or GameStateMachine.currentState == null:
		if event is InputEventKey and event.is_action_pressed("esc"):
			toggle_pause();


func toggle_pause():
	is_paused = !is_paused;
	get_tree().paused = is_paused;

	if is_paused:
		self.show();
	else:
		self.hide();

	if is_paused:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE);
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED);


func set_fullscreen(full: bool):
	var window = get_window();
	var screen_size = DisplayServer.screen_get_size();
	
	if(full):
		window.mode = Window.MODE_FULLSCREEN;
	else:
		window.mode = Window.MODE_WINDOWED;
		window.size = Vector2i(screen_size.x - 66, screen_size.y - 1);
		window.position = Vector2i(
			(screen_size.x - window.size.x)*0.5, 
			(screen_size.y - window.size.y) + 200);


func _on_fullscreen_button_pressed():
	is_fullscreen = !is_fullscreen;
	set_fullscreen(is_fullscreen);

	if (is_fullscreen):
		text_fullscreen.text = "YES";
	else:
		text_fullscreen.text = "NO";
		

func _on_continue_pressed():
	call_deferred("toggle_pause");
	self.hide();


func _on_settings_pressed():
	click_audio.play();
	$Main.hide();
	$Settings.show();


func _on_main_menu_pressed():
	click_audio.play();
	GameStateMachine.changeState(GameStateMachine.GAME_STATE.MAIN_MENU);


func _on_exit_pressed():
	click_audio.play();
	get_tree().quit();


func _on_mouse_hovered():
	click_audio.play();


func _on_back_pressed():
	click_audio.play();
	$Settings.hide();
	$Main.show();
