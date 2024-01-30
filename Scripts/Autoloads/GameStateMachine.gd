extends Node

enum GAME_STATE {
	MAIN_MENU,
	ANIMATION,
	PLAYING,
	GAME_OVER,
}

var currentState: GAME_STATE;
var lastState: GAME_STATE;

signal stateChange(state, oldState);

var mainMenu: String = "res://Scenes/MainMenu.tscn";
var gameplay: String = "res://Scenes/Gameplay.tscn";

func changeState(newState: GAME_STATE) -> bool:
	if newState == currentState:
		return false;
	lastState = currentState;
	currentState = newState;
	
	var root = get_tree();
	match(newState):
		GAME_STATE.MAIN_MENU:
			root.paused = false;
			root.change_scene_to_file(mainMenu);
		GAME_STATE.PLAYING:
			root.paused = false;
			if(lastState == GAME_STATE.GAME_OVER):
				root.reload_current_scene();
			else:
				root.change_scene_to_file(gameplay);
		GAME_STATE.GAME_OVER:
			root.paused = true;
			
	emit_signal("stateChange", currentState, lastState);
	return true;
