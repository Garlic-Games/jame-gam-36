extends Node

signal on_last_message_received;

@export var texture_info : Sprite2D = null;
@export var label_info : Label = null;

enum InformationState {
	FIRST,
	LAST
}

var info_state : InformationState = InformationState.FIRST;


func _ready():
	texture_info.modulate.a = 0.0;


func spawn_info(set_info_state : InformationState):
	var tween_info = get_tree().create_tween();
	tween_info.tween_property(texture_info, "modulate:a", 1.0, 0.0);
	match set_info_state:
		InformationState.FIRST:
			tween_info.tween_property(label_info, "text", "Howdy.", 0.0);
			tween_info.tween_interval(3.0);
			tween_info.tween_property(label_info, "text", "To complete your assigned mission, you will have to generate heat. Find the birds and set them on fire with your smoking hot candle to generate global warming units.", 0.0);
			tween_info.tween_interval(8.0);
			tween_info.tween_property(label_info, "text", "Be careful. Your wax supply is limited. To recharge it you will have to use your shotgun on me. Use the mouse wheel or press Q to change your weapon.", 0.0);
			tween_info.tween_interval(8.0);
			tween_info.tween_property(label_info, "text", "Generate enough global warming units in the planet to melt the barriers blocking your access to the next section.", 0.0);
			tween_info.tween_interval(6.0);
			tween_info.tween_property(label_info, "text", "When I consider you have caused enough global warming on my planet, I will activate the portal to your world.", 0.0);
			tween_info.tween_interval(6.0);
			tween_info.tween_property(label_info, "text", "Mediocre luck on your mission.", 0.0);
			tween_info.tween_interval(4.0);
			tween_info.tween_property(texture_info, "modulate:a", 0.0, 0.0);

		InformationState.LAST:
			tween_info.tween_property(label_info, "text", "You have completed your mission.", 0.0);
			tween_info.tween_interval(4.0);
			tween_info.tween_property(label_info, "text", "But at what cost?", 0.0);
			tween_info.tween_interval(3.0);

			tween_info.tween_property(texture_info, "modulate:a", 0.0, 0.0);
			tween_info.tween_callback(func(): on_last_message_received.emit());
