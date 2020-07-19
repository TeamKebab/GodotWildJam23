extends Node2D


const SoreSpot = preload("res://src/entities/SoreSpot.tscn")


const MIN_X = 3
const MAX_X = 7


export var min_seconds : int = 10
export var max_seconds : int = 20
export var heal_time : int = 30


onready var grid : Grid = find_parent("Game").find_node("Grid")
onready var container: YSort = $Spots
onready var timer: Timer = $Timer


func _ready() -> void:
	timer.connect("timeout", self, "_on_Timer_timeout")	


func start() -> void:
	timer.start(rand_range (min_seconds, max_seconds))


func restart() -> void:
	timer.stop()
	
	for spot in container.get_children():
		spot.queue_free()


func _on_Timer_timeout() -> void:
	_spawn()
	timer.start(rand_range (min_seconds, max_seconds))


func spawn(spots: Array):
	for options in spots:
		var cell = Vector2(options.x, options.y)
		
		var spot = SoreSpot.instance()
		spot.hide()
		container.add_child(spot)
		
		if "heal_time" in options:
			spot.duration = options.heal_time
		
		var position = grid.grid_to_world(cell)
		spot.global_position = position
	
		if _can_place(spot):
			spot.show()
		else:
			spot.queue_free()


func _spawn() -> void:
	var spot = SoreSpot.instance()
	spot.duration = heal_time
	spot.hide()
	container.add_child(spot)

	var placed = false

	for i in range(3):
		var cell = _get_random_cell()
		var position = grid.grid_to_world(cell)
		spot.global_position = position

		if _can_place(spot):
			placed = true
			break

	if placed:
		spot.show()
	else:
		spot.queue_free()


func _can_place(spot : Area2D) -> bool:	
	var overlapping_bodies = spot.get_overlapping_bodies()
	return overlapping_bodies.empty()


func _get_random_cell():
	var x = randi() % (MAX_X - MIN_X) + MIN_X
	var y = randi() % int(grid.size.y)
	
	return Vector2(x,y)
