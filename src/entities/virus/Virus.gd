extends KinematicBody2D
class_name Virus


signal destroyed


const AntiBodies = preload("res://src/entities/AntiBodies.tscn")


export var max_hp: float = 2
export var antibodies_amount = 1
export var damage: float = 1
export var cooldown: float = 3
export var velocity = 80
export var freq_min = 5
export var freq_max = 20
export var max_vertical_movement = 8

export var sound_cooldown_min = 1
export var sound_cooldown_max = 3


var hp: float = max_hp setget set_hp

var virus_type : int = Player.Virus.CUTEVID

var affected_defenses: Array = []
var time: float = 0
var freq: float = freq_min
var base_y: float = 0
var win_x: float = 0
var statuses: Array = []


onready var antibodies_container : Node2D = find_parent("Game").find_node("AntiBodies")
onready var hitbox : Area2D = $HitBox
onready var hpbar : MiniBar = $HP
onready var timer : Timer = $Timer
onready var sprite : AnimatedSprite = $Sprite

onready var dying_sound : AudioStreamPlayer2D = $DyingSound
onready var eating_sound : AudioStreamPlayer2D = $EatingSound
onready var random_sound : AudioStreamPlayer2D = $RandomSound
onready var entering_sound : AudioStreamPlayer2D = $EnteringSound
onready var random_sound_timer : Timer = $RandomSoundTimer


func _ready():
	hitbox.connect("area_entered", self, "_on_hitbox_area_entered")
	hitbox.connect("area_exited", self, "_on_hitbox_area_exited")
	timer.connect("timeout", self, "_on_timer_timeout")
	random_sound_timer.connect("timeout", self, "_on_random_sound_timer_timeout")
	
	freq = Player.rng.randf_range(freq_min, freq_max)
	base_y = position.y
	
	max_hp = max_hp * Player.multiplier
	hp = max_hp
	
	hpbar.total = max_hp
	hpbar.value = hp
	
	entering_sound.play()
	_setup_sound_timer()


func set_hp(new_hp) -> void:
	hp = new_hp
	hpbar.value = hp

	if hp <= 0:
		_die()


func set_status(status) -> void:
	add_child(status)
	
	if statuses.empty():		
		sprite.modulate = Color(0.3, 0.3, 1)
		
	statuses.append(status)
	status.start_status(self)
	
	yield(status, "status_ended")
	
	statuses.erase(status)
	
	if statuses.empty():	
		sprite.modulate = Color(1, 1, 1)


func _physics_process(delta):	
	_move(delta)


func _move(delta):
	var motion = Vector2(velocity, 0)
	
	var collision = move_and_collide(motion * delta)
	
	if collision == null:
		time += delta
		
		position.y = base_y + max_vertical_movement * cos(time * freq)

	if global_position.x > win_x:
		Player.game_over()
		queue_free()


func _setup_sound_timer():
	var time = Player.rng.randf_range(sound_cooldown_min, sound_cooldown_max)
	random_sound_timer.start(time)


func _on_random_sound_timer_timeout():
	random_sound.play()
	_setup_sound_timer()


func _on_hitbox_area_entered(hurtbox: Area2D) -> void:
	var defense = hurtbox.owner

	if defense == null or not defense.has_method("set_hp"):
		return

	_start_targetting_defense(defense)


func _on_hitbox_area_exited(hurtbox: Area2D) -> void:
	var defense = hurtbox.owner
	_stop_targetting_defense(defense)


func _on_defense_destroyed(defense):
	_stop_targetting_defense(defense)


func _start_targetting_defense(defense):
	if not defense in affected_defenses:
		affected_defenses.append(defense)
		defense.connect("destroyed", self, "_on_defense_destroyed")
		
	if timer.is_stopped():
		_do_damage(defense)
		timer.start(cooldown)
	
	if not eating_sound.playing and not defense is Hair:
		eating_sound.play()


func _stop_targetting_defense(defense):
	if defense in affected_defenses:
		affected_defenses.erase(defense)
		defense.disconnect("destroyed", self, "_on_defense_destroyed")
	
	if affected_defenses.empty():
		eating_sound.stop()


func _on_timer_timeout() -> void:
	var to_remove : Array = []
	
	for defense in affected_defenses:
		if defense == null or defense.hp <= 0:
			to_remove.append(defense)
		else:
			_do_damage(defense)
	
	for defense in to_remove:
		affected_defenses.erase(defense)
		
	if not affected_defenses.empty():
		timer.start(cooldown)
	

func _do_damage(defense):
	if not defense is Hair:
		defense.hp -= damage


func _die() -> void:
	var antibodies = AntiBodies.instance()
	antibodies.amount = antibodies_amount
	antibodies.global_position = global_position
	antibodies.global_position.y += randi() % 32 - 16
	antibodies_container.add_child(antibodies)

	dying_sound.play()
	hide()
	
	
	yield(dying_sound, "finished")
	
	# todo: use variable for $HurtBox
	emit_signal("destroyed", $HurtBox)
	queue_free()

