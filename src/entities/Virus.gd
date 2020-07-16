extends KinematicBody2D

signal destroyed


const AntiBodies = preload("res://src/entities/AntiBodies.tscn")


export var max_hp: float = 2
export var antibodies_amount = 1
export var damage: float = 1
export var cooldown: float = 3
export var velocity = 80
export var freq_min = 5
export var freq_max = 20
export var max_vertical_movement = 10
export var rotation_speed_min = -1
export var rotation_speed_max = 1


var hp: float = max_hp setget set_hp

var affected_defenses: Array = []
var time: float = 0
var freq: float = freq_min
var base_y: float = 0
var rotation_speed = rotation_speed_min
var win_x: float = 0

onready var antibodies_container : Node2D = find_parent("Game").find_node("AntiBodies")
onready var hitbox : Area2D = $HitBox
onready var hpbar : MiniBar = $HP
onready var timer : Timer = $Timer
onready var sprite : AnimatedSprite = $Sprite


func _ready():
	hitbox.connect("area_entered", self, "_on_hitbox_area_entered")
	hitbox.connect("area_exited", self, "_on_hitbox_area_exited")
	timer.connect("timeout", self, "_on_timer_timeout")
	
	freq = Player.rng.randf_range(freq_min, freq_max)
	base_y = position.y
	
	rotation_speed = Player.rng.randf_range(rotation_speed_min, rotation_speed_max)
	
	max_hp = max_hp * Player.multiplier
	hp = hp * Player.multiplier
	
	hpbar.total = max_hp
	hpbar.value = hp

	
func set_hp(new_hp) -> void:
	hp = new_hp
	hpbar.value = hp

	if hp <= 0:
		_die()


func _physics_process(delta):
	sprite.rotate(delta * rotation_speed)	
	
	var motion = Vector2(velocity, 0)
	
	var collision = move_and_collide(motion * delta)
	
	if collision == null:
		time += delta
		
		position.y = base_y + max_vertical_movement * cos(time * freq)

	if global_position.x > win_x:
		Player.game_over()
		queue_free()
		
		
func _on_hitbox_area_entered(hurtbox: Area2D) -> void:
	var defense = hurtbox.owner

	if defense == null or not defense.has_method("set_hp"):
		return

	if not defense in affected_defenses:
		affected_defenses.append(defense)
		
	if timer.is_stopped():
		defense.hp -= damage
		timer.start(cooldown)
	
	
func _on_hitbox_area_exited(hurtbox: Area2D) -> void:
	var defense = hurtbox.owner

	if defense in affected_defenses:
		affected_defenses.erase(defense)
	
	
func _on_timer_timeout() -> void:
	var to_remove : Array = []
	
	for defense in affected_defenses:
		if defense == null or defense.hp <= 0:
			to_remove.append(defense)
		else:
			defense.hp -= damage
	
	for defense in to_remove:
		affected_defenses.erase(defense)
		
	if not affected_defenses.empty():
		timer.start(cooldown)
	
	
func _die() -> void:
	var antibodies = AntiBodies.instance()
	antibodies.amount = antibodies_amount
	antibodies.global_position = global_position
	antibodies.global_position.y += randi() % 32 - 16
	antibodies_container.add_child(antibodies)

	emit_signal("destroyed", self)
	queue_free()

