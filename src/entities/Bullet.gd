extends KinematicBody2D


const VELOCITY = 500


export var damage : float = 1
export var rotation_speed = 3

var direction = Vector2.ONE


onready var hitbox : Area2D = $HitBox


func _ready() -> void:
	hitbox.connect("area_entered", self, "_on_hitbox_area_entered")


func _physics_process(delta) -> void:
	var collision = move_and_collide(direction * VELOCITY * delta)
	
	rotate(delta * rotation_speed)	

func _on_hitbox_area_entered(hurtbox: Area2D) -> void:
	var virus = hurtbox.owner

	if not virus.has_method("set_hp"):
		return

	virus.hp -= damage

	# TODO play animation & wait for end
	queue_free()
