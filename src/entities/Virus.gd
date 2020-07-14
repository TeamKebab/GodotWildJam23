extends KinematicBody2D
class_name Virus

signal destroyed

const AntiBodies = preload("res://src/entities/AntiBodies.tscn")


export var max_hp: float = 20
export var antibodies_amount = 1
export var max_velocity = 100


var hp: float

var multiplier : float = 1 setget set_multiplier
var velocity = Vector2.ZERO
var acceleration = Vector2.RIGHT * 50


onready var antibodies_container : Node2D = find_parent("Game").find_node("AntiBodies")
onready var hurtbox : Area2D = $HurtBox
onready var hitbox : HitBox = $HitBox
onready var hpbar : MiniBar = $HP


func _ready():
	hurtbox.connect("area_entered", self, "_on_hurtbox_area_entered") 
	
	hp = max_hp
	hpbar.total = max_hp
	hpbar.value = hp
	
	
func set_multiplier(new_multiplier) -> void:
	hp = hp / multiplier * new_multiplier
	max_hp = max_hp / multiplier * new_multiplier
	multiplier = new_multiplier
	
	if hpbar != null:
		hpbar.total = max_hp
		hpbar.value = hp

	
func _physics_process(delta):
	velocity = (velocity + acceleration * delta).clamped(max_velocity)
	
	var collision = move_and_collide(velocity * delta)
	if collision != null:
		velocity = Vector2.ZERO
	

func _on_hurtbox_area_entered(hitbox: HitBox) -> void:
	if hitbox == null:
		return
		
	hp -= hitbox.damage
	hpbar.value = hp
	
	if hp <= 0:
		var antibodies = AntiBodies.instance()
		antibodies.amount = antibodies_amount
		antibodies.global_position = global_position
		antibodies.global_position.y += randi() % 32 - 16
		antibodies_container.add_child(antibodies)
		
		emit_signal("destroyed", self)
		queue_free()
