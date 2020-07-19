extends Virus
class_name Firevid

export var wall_damage : float  = 4


func _ready():
	virus_type = Player.Virus.FIREVID


func _do_damage(defense):	
	if defense is SnotWall:
		defense.hp -= wall_damage
	elif defense is Hair:
		defense.hp = 0
	else:
		._do_damage(defense)
