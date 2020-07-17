extends KinematicBody2D

signal destroyed(defense)

export var hp : float = 2 setget set_hp

onready var hpbar : MiniBar = $HP
onready var sprite : AnimatedSprite = $Sprite


func _ready() -> void:
	hpbar.total = hp
	hpbar.value = hp


func set_hp(new_hp) -> void:
	hp = new_hp
	
	if hpbar != null:
		hpbar.value = hp

	if hp <= 0:
		_die()


func _die():
	emit_signal("destroyed", self)
	queue_free()
