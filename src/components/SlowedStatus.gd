extends Timer


signal status_ended(status)


var velocity_factor: float = 0.5
var duration: float = 3


func start_status(entity) -> void:
	start(duration)
	entity.velocity *= velocity_factor

	yield(self, "timeout")
	
	entity.velocity /= velocity_factor
	emit_signal("status_ended", self)
	
	queue_free()
	
