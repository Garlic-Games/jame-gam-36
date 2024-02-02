extends Area3D

@export var current_music: AudioStreamPlayer;
@export var next_music: AudioStreamPlayer;
@export var fade_time: float = 5;
var used = false;
func _on_body_entered(body):
	if used:
		return;
	used = true;
	print("Music change zone entered");
	var tween_music = get_tree().create_tween().parallel();
	tween_music.tween_property(current_music, "volume_db", -10.0,fade_time);
	tween_music.parallel().tween_callback(next_music.play);
	tween_music.parallel().tween_property(next_music, "volume_db", .0, fade_time);
	tween_music.tween_callback(current_music.stop).set_delay(fade_time);
	
	
