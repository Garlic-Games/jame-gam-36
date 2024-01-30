extends Node3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func StartGame():
	GameStateMachine.changeState(GameStateMachine.GAME_STATE.PLAYING);
