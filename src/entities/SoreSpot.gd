extends Area2D


export var hp : int = 1
export var duration : int = 30


onready var hurtbox : Area2D = $HurtBox
onready var sprite : Sprite = $Sprite
onready var timer : Timer = $Timer


func _ready() -> void:
	hurtbox.connect("area_entered", self,
		"_on_hurtbox_area_entered")
	timer.connect("timeout", self, "_on_timer_timeout")

	timer.start(duration)
	

func _on_timer_timeout() -> void:
	#sprite.play("heal")
	#yield(sprite, "animation_finished")	
	queue_free()
	
	
func _on_hurtbox_area_entered(hitbox: HitBox) -> void:
	var virus : Virus = hitbox.owner
	
	if virus == null:
		return
		
	hp -= hitbox.damage
	
	if hp <= 0:
		Player.spot_infected = true
		
		#sprite.play("infected")
		#yield(sprite, "animation_finished")		
		queue_free()
