extends Node

@export var label_subtitles : Label = null;
@export var fade_rectangle : ColorRect = null;

var animation_started : bool = false;


func _ready():
	start_animation();


func start_animation():
	var tween_subtitle = get_tree().create_tween();
	tween_subtitle.tween_property(fade_rectangle, "color:a", 0.0, 2);
	tween_subtitle.tween_interval(1.0);
	tween_subtitle.tween_property(label_subtitles, "text", "Greetings, my fellow prisoner.", 1.5);
	tween_subtitle.tween_interval(2.0);
	tween_subtitle.tween_property(label_subtitles, "text", "", 0.0);
	tween_subtitle.tween_property(label_subtitles, "text", "I brought you to my homeworld for a very special mission.", 2.9);
	tween_subtitle.tween_interval(2.0);
	tween_subtitle.tween_property(label_subtitles, "text", "", 0.0);
	tween_subtitle.tween_property(label_subtitles, "text", "You are notorious for your successful efforts in the fight against the global warming.", 4.3);
	tween_subtitle.tween_interval(2.0);
	tween_subtitle.tween_property(label_subtitles, "text", "", 0.0);
	tween_subtitle.tween_property(label_subtitles, "text", "Today, you will be the villain.", 1.5);
	tween_subtitle.tween_interval(2.0);
	tween_subtitle.tween_property(label_subtitles, "text", "", 0.0);
	tween_subtitle.tween_property(label_subtitles, "text", "For your mission to be successful you will heat my planet to collosal levels.", 3.9);
	tween_subtitle.tween_interval(2.0);
	tween_subtitle.tween_property(label_subtitles, "text", "", 0.0);
	tween_subtitle.tween_property(label_subtitles, "text", "Only then you will return to your insignificant global unwarmed world.", 3.5);
	tween_subtitle.tween_interval(2.0);
	tween_subtitle.tween_property(label_subtitles, "text", "", 0.0);
	tween_subtitle.tween_property(label_subtitles, "text", "Take your weapon.", 0.9);
	tween_subtitle.tween_interval(6.0);
	tween_subtitle.tween_property(label_subtitles, "text", "", 0.0);
	tween_subtitle.tween_property(label_subtitles, "text", "Now you are ready. Have fon.", 1.4);
	tween_subtitle.is_queued_for_deletion();

