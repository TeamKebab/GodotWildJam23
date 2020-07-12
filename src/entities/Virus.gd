extends KinematicBody2D
class_name Virus

signal destroyed

const AntiBodies = preload("res://src/entities/AntiBodies.tscn")

const MAX_VELOCITY = 100

var hp = 2
var velocity = Vector2.ZERO
var acceleration = Vector2.RIGHT * 50

onready var antibodies_container : Node2D = find_parent("Game").find_node("AntiBodies")
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
		var antibodies = AntiBodies.instance()
		antibodies.amount = 1
		antibodies.global_position = global_position
		antibodies.global_position.y += randi() % 32 - 16
		antibodies_container.add_child(antibodies)
		
		emit_signal("destroyed", self)
		queue_free()
