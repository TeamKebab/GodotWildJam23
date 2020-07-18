extends "res://src/entities/virus/Virus.gd"


export var rotation_speed_min = -1
export var rotation_speed_max = 1


var rotation_speed = rotation_speed_min


func _ready() -> void:
	rotation_speed = Player.rng.randf_range(rotation_speed_min, rotation_speed_max)
	

func _physics_process(delta):
	sprite.rotate(delta * rotation_speed)
