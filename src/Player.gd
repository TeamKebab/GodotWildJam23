extends Node


signal antibodies_changed(new_antibodies)


var antibodies: int = 5 setget set_antibodies
var multiplier: float = 1


func _ready() -> void:
	randomize()
	
	
func set_antibodies(new_antibodies) -> void:
	antibodies = new_antibodies
	emit_signal("antibodies_changed", new_antibodies)	


func infect() -> void:
	multiplier = multiplier * 1.5
	
	
func heal() -> void:
	multiplier = multiplier / 1.5
	if multiplier < 1:
		multiplier = 1
