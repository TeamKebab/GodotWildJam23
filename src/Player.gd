extends Node


signal antibodies_changed(new_antibodies)


var antibodies: int = 0 setget set_antibodies


func set_antibodies(new_antibodies):
	antibodies = new_antibodies
	emit_signal("antibodies_changed", new_antibodies)	
	
