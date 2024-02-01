extends CanvasLayer


func _ready():
	hide();


func _on_back_pressed():
	hide();
	get_parent().get_node("Main").show();
