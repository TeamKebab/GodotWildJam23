extends Virus
class_name Ghostvid

signal revealed
signal disappeared

var revealed:bool = true setget _set_revealed
var identivids = []


onready var detection : Area2D = $DetectionBox
onready var hurtbox: Area2D = $HurtBox
onready var shape: CollisionShape2D = $CollisionShape2D


func _ready():
	_set_revealed(false)
	
	detection.connect("area_entered", self, 
		"_on_detection_area_entered")
	detection.connect("area_exited", self,
		"_on_detection_area_exited")


func _on_detection_area_entered(area: Area2D) -> void:
	var identivid : Identivid = area.owner
	
	if identivid != null:
		identivids.append(identivid)
		identivid.connect("destroyed", self, "_on_identivid_destroyed")
		_set_revealed(true)


func _on_detection_area_exited(area: Area2D) -> void:
	var identivid : Identivid = area.owner
	
	if identivid != null:
		identivids.erase(identivid)
		
		if identivids.empty():
			_set_revealed(false)


func _on_identivid_destroyed(identivid) -> void:
	identivids.erase(identivid)
		
	if identivids.empty():
		_set_revealed(false)


func _set_revealed(value) -> void:
	if revealed == value:
		return

	revealed = value
	
	shape.set_deferred("disabled", not revealed)
	hitbox.set_disabled(not revealed)
		
	if revealed:
		sprite.play("visible")
		emit_signal("revealed", hurtbox)
	else:
		sprite.play("hidden")
		emit_signal("disappeared", hurtbox)