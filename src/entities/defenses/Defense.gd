extends KinematicBody2D
class_name Defense


signal destroyed(defense)
signal hp_changed(old_hp, new_hp)

export var hp : float = 2 setget set_hp

onready var hpbar : MiniBar = $HP
onready var sprite : AnimatedSprite = $Sprite


func _ready() -> void:
	hpbar.total = hp
	hpbar.value = hp


func set_hp(new_hp) -> void:
	if (new_hp != hp):
		emit_signal("hp_changed", hp, new_hp)
		
	hp = new_hp
	
	if hpbar != null:
		hpbar.value = hp

	if hp <= 0:
		_die()


func _die():
	emit_signal("destroyed", self)
	queue_free()
