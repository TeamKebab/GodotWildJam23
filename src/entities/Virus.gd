extends KinematicBody2D

signal destroyed

const MAX_VELOCITY = 100

var hp = 2
var velocity = Vector2.ZERO
var acceleration = Vector2.RIGHT * 50

onready var hurtbox : Area2D = $HurtBox

func _ready():
	hurtbox.connect("area_entered", self, "_on_hurtbox_area_entered") 
	
	
func _physics_process(delta):
	velocity = (velocity + acceleration * delta).clamped(MAX_VELOCITY)
	
	var collision = move_and_collide(velocity * delta)


func _on_hurtbox_area_entered(hitbox: HitBox) -> void:
	if hitbox == null:
		return
		
	hp -= hitbox.damage
	
	if hp <= 0:
		emit_signal("destroyed", self)
		queue_free()
