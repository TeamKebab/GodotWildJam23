extends Area2D


onready var shape : CollisionShape2D = $CollisionShape2D


func set_disabled(disabled):
	shape.set_deferred("disabled", disabled)
