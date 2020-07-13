extends Node


signal antibodies_changed(new_antibodies)


var antibodies: int = 1 setget set_antibodies


func _ready() -> void:
	randomize()
	
	
func set_antibodies(new_antibodies) -> void:
	antibodies = new_antibodies
	emit_signal("antibodies_changed", new_antibodies)	
