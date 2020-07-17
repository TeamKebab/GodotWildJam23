extends Node2D

enum Virus {
	CUTEVID,
	OGREVID,
	GHOSTVID,
}

const VIRUS = {
	Virus.CUTEVID : preload("res://src/entities/Cutevid.tscn"),	
	Virus.OGREVID : preload("res://src/entities/Ogrevid.tscn"),
	Virus.GHOSTVID : preload("res://src/entities/Ghostvid.tscn"),
}

const WAVES = [
	{
		"wait": 0.5,
		"times": 1,
		"virus":[
			{
				"type": Virus.GHOSTVID,
				"row": 1
			},
			{
				"type": Virus.GHOSTVID,
				"row": 2
			}
		]
	},
	{
		"wait": 0.5,
		"times": 1,
		"virus":[
			{
				"type": Virus.CUTEVID,
				"row": 1
			},
			{
				"type": Virus.GHOSTVID,
				"row": 2
			}
		]
	},
	{
		"wait": 5,
		"times": 2,
		"virus":[
			Virus.CUTEVID,
		]
	}	
]

var waves_left = []

onready var grid : Grid = find_parent("Game").find_node("Grid")
onready var container: YSort = $Virus
onready var timer: Timer = $Timer


func _ready() -> void:	
	Player.connect("game_over", self, "_on_game_over")
	Player.connect("restart", self, "_on_restart")
	
	timer.connect("timeout", self, "_on_Timer_timeout")

	restart()


func _on_game_over() -> void:
	timer.stop()
	
	for virus in container.get_children():
		virus.queue_free()
	

func _on_restart() -> void:
	restart()


func restart() -> void:		
	waves_left = WAVES.duplicate(true)
	timer.start(waves_left[0].wait)
	
	
func _on_virus_destroyed(hurtbox) -> void:
	var virus = hurtbox.get_parent()
	
	container.remove_child(virus)
	
	if waves_left.empty():
		var children_left = container.get_child_count()
		
		if children_left == 0:
			Player.game_over()
			
	
func _on_Timer_timeout():
	var wave = waves_left[0]

	if "times" in wave and wave.times > 1:
		wave.times -= 1
	else:
		waves_left.remove(0)

	_spawn_wavelet(wave)

	if not waves_left.empty():
		timer.start(waves_left[0].wait)
		

func _spawn_wavelet(wave):
	assert(wave.virus.size() <= int(grid.size.y))

	var possible_rows = _get_possible_rows()

	for virus in wave.virus:
		var virus_type = -1
		var virus_row = -1

		if virus is int:
			virus_type = virus	
		else:
			virus_type = virus.type
			if "row" in virus and virus.row in possible_rows:
				virus_row = virus.row
				possible_rows.remove(virus.row)

		if virus_row < 0 or virus_row >= grid.size.y:
			virus_row = _get_random(possible_rows)

		_spawn(virus_type, virus_row)


func _spawn(type: int, row: int):
	var virus = VIRUS[type].instance()

	virus.global_position = grid.grid_to_world(Vector2(0, row))
	virus.win_x = grid.grid_to_world(grid.size).x
	
	container.add_child(virus)
	virus.connect("destroyed", self, "_on_virus_destroyed")


func _get_random(possible_rows: Array) -> int:
	var i = Player.rng.randi() % possible_rows.size()
	var row = possible_rows[i]
	possible_rows.remove(i)
	return row


func _get_possible_rows() -> Array:
	return range(0, int(grid.size.y))
