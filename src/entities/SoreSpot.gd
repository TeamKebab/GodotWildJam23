extends Area2D


export var hp : float = 1 setget set_hp
export var duration : int = 30


onready var hurtbox : Area2D = $HurtBox
onready var sprite : Sprite = $Sprite
onready var timer : Timer = $Timer

onready var appear_sound : AudioStreamPlayer2D = $AppearSound
onready var infect_sound : AudioStreamPlayer2D = $InfectSound
onready var heal_sound : AudioStreamPlayer2D = $HealSound


func _ready() -> void:
	timer.connect("timeout", self, "_on_timer_timeout")
	timer.start(duration)
	appear_sound.play()
	

func set_hp(new_hp) -> void:
	hp = new_hp

	if hp <= 0:
		_die()
		
		
func _on_timer_timeout() -> void:
	Player.heal()
	#sprite.play("heal")
	heal_sound.play()
	
	#yield(sprite, "animation_finished")	
	hide()
	
	yield(heal_sound, "finished")
	
	queue_free()


func _die():
	Player.infect()
		
	#sprite.play("infected")
	infect_sound.play()
	
	#yield(sprite, "animation_finished")		
	hide()
	
	yield(infect_sound, "finished")
	queue_free()	
	
