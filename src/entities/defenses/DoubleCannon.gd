extends Cannon


func _shoot_target() -> void:
	._shoot_target()
	
	yield(sprite, "animation_finished")
	
	._shoot_target()
