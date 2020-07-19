extends Virus


export var wall_damage : float  = 4


func _do_damage(defense):	
	if defense is SnotWall:
		defense.hp -= wall_damage
	elif defense is Hair:
		defense.hp = 0
	else:
		._do_damage(defense)
