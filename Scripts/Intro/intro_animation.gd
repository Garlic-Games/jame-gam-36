extends Node

@export_group("Animation Settings")
@export var music : AudioStreamPlayer = null;
@export var time_to_skip : float = 3.0;
@export var label_subtitles : Label = null;
@export var fade_rectangle : ColorRect = null;
@export var raygun : Node3D = null;
@export var raygun_target_transform : Node3D = null;


var animation_started : bool = false;
var timer_skip = 0.0;
var is_skip_pressed = false;

func _ready():
	start_animation();
	

func _input(event):
	if event is InputEventKey and Input.is_action_pressed("jump"):
		is_skip_pressed = true;

	elif event is InputEventKey and event.is_action_released("jump"):
		is_skip_pressed = false;


func _process(delta):
	if is_skip_pressed:
		timer_skip += delta;

		if timer_skip >= time_to_skip:
			end_animation();
	else:
		timer_skip = 0.0;


func start_animation():
	music.play();
	var tween_music = get_tree().create_tween();
	tween_music.tween_property(music, "volume_db", -15, 2.0);
	
	var tween_animation = get_tree().create_tween();
	tween_animation.tween_property(fade_rectangle, "color:a", 0.0, 1);
	tween_animation.tween_interval(1.0);
	tween_animation.tween_property(label_subtitles, "text", "Greetings, my fellow prisoner.", 1.5);
	tween_animation.tween_interval(2.0);
	tween_animation.tween_property(label_subtitles, "text", "", 0.0);
	tween_animation.tween_property(label_subtitles, "text", "I brought you to my homeworld for a very special mission.", 2.9);
	tween_animation.tween_interval(2.0);
	tween_animation.tween_property(label_subtitles, "text", "", 0.0);
	tween_animation.tween_property(label_subtitles, "text", "You are notorious for your successful efforts in the fight against the global warming.", 4.3);
	tween_animation.tween_interval(2.0);
	tween_animation.tween_property(label_subtitles, "text", "", 0.0);
	tween_animation.tween_property(label_subtitles, "text", "Today you will be the villain.", 1.5);
	tween_animation.tween_interval(2.0);
	tween_animation.tween_property(label_subtitles, "text", "", 0.0);
	tween_animation.tween_property(label_subtitles, "text", "For your mission to be successful, you will heat my planet to collosal levels.", 3.9);
	tween_animation.tween_interval(2.0);
	tween_animation.tween_property(label_subtitles, "text", "", 0.0);
	tween_animation.tween_property(label_subtitles, "text", "Only then, you will return to your insignificant global unwarmed world.", 3.6);
	tween_animation.tween_interval(2.0);
	tween_animation.tween_property(label_subtitles, "text", "", 0.0);
	tween_animation.tween_property(label_subtitles, "text", "Take your weapon.", 0.9);
	tween_animation.tween_interval(0.5);
	tween_animation.tween_property(raygun, "global_transform", raygun_target_transform.global_transform, 2.0);
	tween_animation.tween_property(label_subtitles, "text", "", 0.0);
	tween_animation.tween_property(label_subtitles, "text", "Now you are ready. Have fon.", 1.4);
	tween_animation.tween_interval(1.0);
	tween_animation.tween_callback(end_animation);
	tween_animation.is_queued_for_deletion();


func end_animation():
	var tween_animation_end = get_tree().create_tween();
	tween_animation_end.tween_property(fade_rectangle, "color:a", 1.0, 1);
	tween_animation_end.tween_interval(1.0);
	tween_animation_end.tween_callback(load_level);
	var tween_music = get_tree().create_tween();
	tween_music.tween_property(music, "volume_db", -40, 1.0);

func load_level():
	GameStateMachine.changeState(GameStateMachine.GAME_STATE.PLAYING);
