extends CanvasLayer


func _ready():
	hide();


func open_link(link):
	OS.shell_open(link);


func _on_back_pressed():
	hide();
	get_parent().get_node("Main").show();
