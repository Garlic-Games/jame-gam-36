extends CanvasLayer

class_name GameOverManager;

signal restartGame;

func RestartGamePressed():
	emit_signal("restartGame");
