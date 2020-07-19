extends Defense
class_name Hair

export var speed_factor : float = 0.5


var affected_virus : Array = []


onready var hitbox: Area2D = $HitBox
onready var passing_sound: AudioStreamPlayer2D = $PassingSound
onready var burning_sound: AudioStreamPlayer2D = $BurningSound


func _ready() -> void:
	hitbox.connect("area_entered", self, "_on_hitbox_area_entered")
	hitbox.connect("area_exited", self, "_on_hitbox_area_exited")
	

func _on_hitbox_area_entered(hurtbox: Area2D) -> void:
	var virus = hurtbox.owner

	if virus == null:
		return

	_start_targetting(virus)


func _on_hitbox_area_exited(hurtbox: Area2D) -> void:
	var virus = hurtbox.owner
	_stop_targetting(virus)


func _start_targetting(virus):
	if virus.virus_type == Player.Virus.FIREVID:
		return
	if not virus in affected_virus:
		affected_virus.append(virus)
		_modify_speed(virus, speed_factor)
	
	if not passing_sound.playing:
		passing_sound.play()


func _stop_targetting(virus):
	if virus.virus_type == Player.Virus.FIREVID:
		return
	
	if virus in affected_virus:
		affected_virus.erase(virus)	
		_modify_speed(virus, 1 / speed_factor)
		#virus.disconnect("destroyed", self, "_on_defense_destroyed")
	
	if affected_virus.empty():
		passing_sound.stop()



func _modify_speed(virus, factor):
	virus.velocity = virus.velocity * factor


func _die():
	for virus in affected_virus:
		_modify_speed(virus, 1 / speed_factor)
	
	burning_sound.play()
	yield(burning_sound, "finished")
	
	._die()
	

