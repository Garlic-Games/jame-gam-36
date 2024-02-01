extends Node3D
class_name GameplayManager;

@export var gameOverMenu: GameOverManager;

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED;
	GameStateMachine.connect("stateChange", onGameStateChange);

func EndGame():
	GameStateMachine.changeState(GameStateMachine.GAME_STATE.GAME_OVER);


func Restart():
	GameStateMachine.changeState(GameStateMachine.GAME_STATE.PLAYING);


func onGameStateChange(state, _oldState):
	if(state == GameStateMachine.GAME_STATE.GAME_OVER):
		gameOverMenu.show();
	else:
		gameOverMenu.hide();
