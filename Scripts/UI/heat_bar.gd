extends Node


func _ready():
	$"../../Heat".connect("on_heat_changed", func(val): $Control/ProgressBar.value = val);
