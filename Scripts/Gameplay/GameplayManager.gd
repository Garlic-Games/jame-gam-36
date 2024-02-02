extends Node3D
class_name GameplayManager;

@export var gameOverMenu: GameOverManager;
@export var heat : Node = null;
@export var portal : Node3D = null;

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED;
	GameStateMachine.connect("stateChange", onGameStateChange);
	heat.connect("on_heat_filled", turn_on_portal);
	portal.connect("on_portal_entered", EndGame);


func EndGame():
	GameStateMachine.changeState(GameStateMachine.GAME_STATE.GAME_OVER);


func Restart():
	GameStateMachine.changeState(GameStateMachine.GAME_STATE.PLAYING);


func onGameStateChange(state, _oldState):
	if(state == GameStateMachine.GAME_STATE.GAME_OVER):
		gameOverMenu.start_game_over();
	else:
		gameOverMenu.hide();


func turn_on_portal():
	portal.turn_on();
