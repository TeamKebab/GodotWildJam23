extends Defense
class_name Hair

export var speed_factor : float = 0.5


var affected_virus : Array = []


onready var hitbox: Area2D = $HitBox


func _ready() -> void:
	hitbox.connect("area_entered", self, "_on_hitbox_area_entered")
	hitbox.connect("area_exited", self, "_on_hitbox_area_exited")
	

func _on_hitbox_area_entered(hurtbox: Area2D) -> void:
	var virus = hurtbox.owner

	if virus == null:
		return

	if not virus in affected_virus:
		affected_virus.append(virus)
		_modify_speed(virus, speed_factor)


func _on_hitbox_area_exited(hurtbox: Area2D) -> void:
	var virus = hurtbox.owner

	if virus in affected_virus:
		affected_virus.erase(virus)	
		_modify_speed(virus, 1 / speed_factor)


func _modify_speed(virus, factor):
	virus.velocity = virus.velocity * factor


func _die():
	for virus in affected_virus:
		_modify_speed(virus, 1 / speed_factor)
	
	._die()
	

