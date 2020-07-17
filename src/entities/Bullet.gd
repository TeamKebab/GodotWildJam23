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
	var virus = hurtbox.get_parent()

	if virus == null or not virus.has_method("set_hp"):
		return

	if "revealed" in virus and not virus.revealed:
		return
		
	virus.hp -= damage

	# TODO play animation & wait for end
	queue_free()
