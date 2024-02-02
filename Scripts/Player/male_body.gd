class_name MaleBody;
extends Node3D

@onready var anim: AnimationPlayer = $AnimationPlayer;

const WALKANIM: String = "run_001";
const IDLE: String = "idle";

func walk():
	if anim.current_animation != WALKANIM:
		anim.play(WALKANIM);


func idle():
	if anim.current_animation != IDLE:
		anim.play(IDLE);
