extends Node

signal game_over
signal antibodies_changed(new_antibodies)

enum Virus {
	CUTEVID,
	OGREVID,
	GHOSTVID,
	FIREVID,
	FLYVID,
	QUEENVID,
}

enum Defense {
	SNOT_CANNON,
	STICKY_CANNON,
	SNOT_WALL,
	HAIR,
	IDENTIVID,
	DOUBLE_CANNON,
	CATAPULT
}

const ANTIBODIES = 16
const MULTIPLIER = 1

var antibodies: int = ANTIBODIES setget set_antibodies
var multiplier: float = MULTIPLIER
var show_tips: bool = true

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


func restart() -> void:
	set_antibodies(ANTIBODIES)
	multiplier = MULTIPLIER
