extends CanvasLayer

@export var text_fullscreen : Label = null;

var is_fullscreen : bool = false;

func _ready():
	hide();


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


func _on_back_pressed():
	hide();
	get_parent().get_node("Main").show();
