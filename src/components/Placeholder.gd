extends Area2D


export(PackedScene) var entity
export var price:int = 1

func buy() -> KinematicBody2D:
	var instance = entity.instance()
	instance.global_position = global_position
	
	Player.antibodies -= price
	
	return instance
