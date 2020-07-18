extends "res://src/entities/defenses/Bullet.gd"

const SlowedStatus = preload("res://src/components/SlowedStatus.tscn")


export var speed_factor : float = 0.5
export var duration : float = 3

onready var timer : Timer = $Timer


func _do_damage(virus):
	._do_damage(virus)
		
	var status = SlowedStatus.instance()
	status.velocity_factor = speed_factor
	status.duration = duration
	
	virus.set_status(status)
	
