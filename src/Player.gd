extends Node

signal game_over
signal antibodies_changed(new_antibodies)
signal multiplier_changed(new_multiplier)


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

const ANTIBODIES = 20
const MULTIPLIER = 1
const MULTIPLIER_FACTOR = 1.5
const MAX_MULTIPLIER = 3


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
	multiplier = min(multiplier * MULTIPLIER_FACTOR, MAX_MULTIPLIER)
	emit_signal("multiplier_changed", multiplier)


func heal() -> void:
	multiplier = max(multiplier / MULTIPLIER_FACTOR, 1)
	emit_signal("multiplier_changed", multiplier)


func game_over() -> void:
	emit_signal("game_over")


func restart() -> void:
	set_antibodies(ANTIBODIES)
	multiplier = MULTIPLIER
