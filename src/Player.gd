extends Node

signal game_over
signal restart
signal antibodies_changed(new_antibodies)

const ANTIBODIES = 5
const MULTIPLIER = 1

var antibodies: int = ANTIBODIES setget set_antibodies
var multiplier: float = MULTIPLIER

var rng = RandomNumberGenerator.new()


func _ready() -> void:
	rng.randomize()
	
	
func set_antibodies(new_antibodies) -> void:
	antibodies = new_antibodies
	emit_signal("antibodies_changed", new_antibodies)	


func infect() -> void:
	multiplier = multiplier * 1.5
	
	
func heal() -> void:
	multiplier = multiplier / 1.5
	if multiplier < 1:
		multiplier = 1


func game_over() -> void:
	emit_signal("game_over")
	get_tree().paused = true
	

func restart() -> void:
	set_antibodies(ANTIBODIES)
	multiplier = MULTIPLIER
	
	get_tree().paused = false
	emit_signal("restart")
