class_name Steps;
extends Node3D

@onready var step1: AudioStreamPlayer3D = $step1;
@onready var step2: AudioStreamPlayer3D = $step2;

var random: RandomNumberGenerator = RandomNumberGenerator.new();

func walk() -> void:
	if step1.playing || step2.playing:
		return;
		
	if random.randf() > 0.5:
		step1.play(0);
	else:
		step2.play(0);
		
func stop() -> void:
	step1.stop();
	step2.stop();
		
