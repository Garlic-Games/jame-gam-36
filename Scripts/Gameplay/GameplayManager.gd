extends Node3D
class_name GameplayManager;

@export var gameOverMenu: GameOverManager;

func _ready():
	GameStateMachine.connect("stateChange", onGameStateChange);

	$Transitions/Fade/Animation.play("fade_in");


func EndGame():
	GameStateMachine.changeState(GameStateMachine.GAME_STATE.GAME_OVER);


func Restart():
	GameStateMachine.changeState(GameStateMachine.GAME_STATE.PLAYING);


func onGameStateChange(state, oldState):
	if(state == GameStateMachine.GAME_STATE.GAME_OVER):
		gameOverMenu.show();
	else:
		gameOverMenu.hide();
