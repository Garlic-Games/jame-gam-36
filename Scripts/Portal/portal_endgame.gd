extends Node

signal on_portal_entered;


func _ready():
	$PortalShape.hide();


func turn_on():
	$PortalShape.show();
	$PortalInteractionArea.monitoring = true;

func _on_portal_entered(body):
	on_portal_entered.emit();
