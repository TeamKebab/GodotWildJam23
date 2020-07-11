extends KinematicBody2D

const ANGLE_ERROR = 0.001
const ROTATION_SPEED = 1
const COOLDOWN = 3

const Bullet = preload("res://src/entities/Bullet.tscn")

var target : Area2D

onready var time_since_last_shoot: float = COOLDOWN
onready var detection : Area2D = $DetectionBox

func _ready() -> void:
	detection.connect("area_entered", self, 
		"_on_detection_area_entered")
	
	
func _physics_process(delta: float):
	if target == null:
		return
	
	if _point_to_target(delta):
		_shoot_target(delta)
	

func _point_to_target(delta: float) -> bool:
	var target_rotation = target.global_position.angle_to_point(global_position)
	
	if target_rotation - rotation < 0:
		rotation = max(target_rotation, rotation - ROTATION_SPEED * delta)
	else:
		rotation = min(target_rotation, rotation + ROTATION_SPEED * delta)
	
	return abs(target_rotation - rotation) < ANGLE_ERROR
	

func _shoot_target(delta) -> void:
	time_since_last_shoot += delta
	
	if time_since_last_shoot > COOLDOWN:
		var bullet = Bullet.instance()
		
		bullet.direction = Vector2.RIGHT.rotated(rotation)
		self.add_child(bullet)
		time_since_last_shoot = 0
		
		
func _on_detection_area_entered(area: Area2D) -> void:
	if target == null:
		_find_target()		


func _on_target_destroyed() -> void:
	target.owner.disconnect("destroyed", self, "_on_target_destroyed")
	target = null
	_find_target()

	
func _find_target() -> void:
	target = _get_nearest_target(detection.get_overlapping_areas())

	if target == null: 
		return
		
	target.owner.connect("destroyed", self, "_on_target_destroyed")


func _get_nearest_target(targets:Array) -> Area2D:
	if targets.empty():
		return null
	
	var target = targets[0]
	
	for i in targets:
		if i.global_position.distance_to(global_position) < target.global_position.distance_to(global_position):
			target = i
	
	return target
