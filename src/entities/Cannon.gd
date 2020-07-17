extends "res://src/entities/Defense.gd"

const COOLDOWN = 3

const Bullet = preload("res://src/entities/Bullet.tscn")

var targets : Array = []
var current_target : Area2D


onready var time_since_last_shoot: float = COOLDOWN
onready var detection : Area2D = $DetectionBox


func _ready() -> void:
	detection.connect("area_entered", self, 
		"_on_detection_area_entered")
	detection.connect("area_exited", self,
		"_on_detection_area_exited")
	
		
func _physics_process(delta: float):
	time_since_last_shoot += delta
	
	if current_target != null and time_since_last_shoot > COOLDOWN:		
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
	if _is_valid_target(area):
		area.get_parent().connect("destroyed", self, "_on_target_destroyed")
		targets.append(area)
		
	if current_target == null:
		_find_target()		


func _on_detection_area_exited(area: Area2D) -> void:
	_remove_target(area)


func _on_target_destroyed(area) -> void:
	_remove_target(area)


func _remove_target(area: Area2D) -> void:
	var virus = area.get_parent()
	
	if targets.has(area):
		targets.erase(area)
		
		if virus != null:
			virus.disconnect("destroyed", self, "_on_target_destroyed")
		
		if area == current_target:
			_find_target()


func _find_target() -> void:
	current_target = null

	for target in targets:
		if not _is_valid_target(target):
			continue
		
		if current_target == null:
			current_target = target
		else:
			if _is_closer(current_target.global_position, target.global_position):
				current_target = target


func _is_closer(current: Vector2, next: Vector2) -> bool:
	return next.distance_to(global_position) < current.distance_to(global_position)


func _is_valid_target(area) -> bool:
	var virus = area.get_parent()
	
	if virus == null:
		return false
		
	if not virus.has_method("set_hp"):
		return false
	
	if virus.hp <= 0:
		return false
		
	return true
