extends Node2D


func restart()-> void:
	for defense in get_children():
		defense.queue_free()
