extends CanvasLayer

class_name GameOverManager;

signal restartGame;

@export var click_audio : AudioStreamPlayer = null;
@onready var fade_screen : ColorRect = $Fade;
@onready var label_you_won : Label = $YouWon;
@onready var label_question : Label = $QuestionMark;

func _ready():
	hide();


func RestartGamePressed():
	pass
	#emit_signal("restartGame");


func start_game_over():
	show();
	get_tree().paused = false;
	label_you_won.hide();
	label_question.modulate.a = 0.0;

	
	var tween_game_over = get_tree().create_tween();
	tween_game_over.tween_property(fade_screen, "color:a", 1.0, 2.0);
	tween_game_over.tween_interval(1.0);
	tween_game_over.tween_callback(func(): label_you_won.show());
	tween_game_over.tween_interval(2.0);
	tween_game_over.tween_property(label_question, "modulate:a", 1.0, 2.0);
	tween_game_over.tween_interval(3.0);
	tween_game_over.tween_callback(func(): 
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE);
		GameStateMachine.changeState(GameStateMachine.GAME_STATE.MAIN_MENU);
	);


func _on_main_menu_pressed():
	click_audio.play();
	GameStateMachine.changeState(GameStateMachine.GAME_STATE.MAIN_MENU);


func _on_button_hovered():
	click_audio.play();
