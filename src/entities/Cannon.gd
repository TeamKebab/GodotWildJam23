extends "res://src/entities/Defense.gd"

const COOLDOWN = 3

const Bullet = preload("res://src/entities/Bullet.tscn")


var target : Area2D


onready var time_since_last_shoot: float = COOLDOWN
onready var detection : Area2D = $DetectionBox


func _ready() -> void:
	detection.connect("area_entered", self, 
		"_on_detection_area_entered")
	detection.connect("area_exited", self,
		"_on_detection_area_exited")
	
		
func _physics_process(delta: float):
	time_since_last_shoot += delta
	
	if target != null and time_since_last_shoot > COOLDOWN:		
		time_since_last_shoot = 0
		_shoot_target()


func _shoot_target() -> void:
	sprite.play("shot")
	
	yield(sprite, "animation_finished")
	
	var bullet = Bullet.instance()
	bullet.position.x = -32
	bullet.direction = Vector2.LEFT
	self.add_child(bullet)
	sprite.play("charge")
	

func _on_detection_area_entered(area: Area2D) -> void:
	if target == null:
		_find_target()		


func _on_detection_area_exited(area: Area2D) -> void:
	if target != null:
		target = null
		_find_target()		


func _on_target_destroyed(virus) -> void:
	target = null
	_find_target()


func _find_target() -> void:
	target = _get_nearest_target(detection.get_overlapping_areas())

	if target == null: 
		return

	target.get_parent().connect("destroyed", self, "_on_target_destroyed")


func _get_nearest_target(targets:Array) -> Area2D:
	var valid_targets : Array = _get_valid_targets(targets)

	if valid_targets.empty():
		return null

	var target = valid_targets[0]

	for i in valid_targets:
		if _is_closer(target.global_position, i.global_position):
			target = i

	return target


func _get_valid_targets(targets:Array) -> Array:
	var valid_targets : Array = []

	for i in targets:
		var virus = i.get_parent()

		if _is_valid_target(virus):
			valid_targets.append(i)

	return valid_targets


func _is_closer(current: Vector2, next: Vector2) -> bool:
	return next.distance_to(global_position) < current.distance_to(global_position)


func _is_valid_target(virus) -> bool:
	if virus == null:
		return false
		
	if not virus.has_method("set_hp"):
		return false
	
	if virus.hp <= 0:
		return false
		
	return true
