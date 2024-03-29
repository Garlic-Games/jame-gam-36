extends Node3D
class_name GameplayManager;

@export var mainMusic : AudioStreamPlayer = null;
@export var finalMusic : AudioStreamPlayer = null;
@export var endMusic : AudioStreamPlayer = null;
@export var tutorial : CanvasLayer = null;
@export var gameOverMenu: GameOverManager;
@export var heat : Node = null;
@export var portal : EndgamePortal = null;
@export var fade_rectangle : ColorRect = null;

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED;
	GameStateMachine.connect("stateChange", onGameStateChange);
	tutorial.connect("on_last_message_received", turn_on_portal);
	heat.connect("on_heat_filled", spawn_last_message);
	portal.connect("on_portal_entered", EndGame);
	
	var tween_transition = get_tree().create_tween();
	tween_transition.tween_property(fade_rectangle, "color:a", 0.0, 2.5);
	mainMusic.play();
	
	tutorial.spawn_info(TutorialInfo.InformationState.FIRST);


func EndGame():
	GameStateMachine.changeState(GameStateMachine.GAME_STATE.GAME_OVER);
	mainMusic.stop();
	finalMusic.stop();
	endMusic.play();
	var tween_music = get_tree().create_tween();
	tween_music.tween_property(endMusic, "volume_db", -10.0, 1.5);
	

func Restart():
	GameStateMachine.changeState(GameStateMachine.GAME_STATE.PLAYING);


func onGameStateChange(state, _oldState):
	if(state == GameStateMachine.GAME_STATE.GAME_OVER):
		gameOverMenu.start_game_over();
	else:
		gameOverMenu.hide();

func spawn_last_message():
	tutorial.spawn_info(TutorialInfo.InformationState.LAST);

func turn_on_portal():
	portal.turn_on();
