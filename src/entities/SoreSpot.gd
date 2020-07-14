extends Area2D


export var hp : float = 1 setget set_hp
export var duration : int = 30


onready var hurtbox : Area2D = $HurtBox
onready var sprite : Sprite = $Sprite
onready var timer : Timer = $Timer


func _ready() -> void:
	timer.connect("timeout", self, "_on_timer_timeout")
	timer.start(duration)
	

func set_hp(new_hp) -> void:
	hp = new_hp

	if hp <= 0:
		_die()
		
		
func _on_timer_timeout() -> void:
	Player.heal()
	#sprite.play("heal")
	#yield(sprite, "animation_finished")	
	queue_free()


func _die():
	Player.infect()
		
	#sprite.play("infected")
	#yield(sprite, "animation_finished")		
	queue_free()	
	
