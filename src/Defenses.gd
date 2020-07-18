extends YSort


func restart()-> void:
	for antibodies in get_children():
		antibodies.queue_free()
