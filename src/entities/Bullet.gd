extends KinematicBody2D

const VELOCITY = 500

var direction = Vector2.ONE

onready var hitbox : HitBox = $HitBox


func _ready() -> void:
	hitbox.connect("area_entered", self, "_on_hitbox_area_entered")
	
	
func _physics_process(delta) -> void:
	var collision = move_and_collide(direction * VELOCITY * delta)


func _on_hitbox_area_entered(hurtbox: Area2D) -> void:
	queue_free()
