extends Node2D

enum Virus {
	CUTEVID
}

const VIRUS = {
	Virus.CUTEVID : preload("res://src/entities/Virus.tscn")	
}

var waves = [
	[
		{
			"wait": 0.5,
			"virus":[
				{
					"virus": Virus.CUTEVID,
					"row": 0
				}
			]
		},
		{
			"wait": 5,
			"virus":[
				Virus.CUTEVID,
				Virus.CUTEVID
			]
		},
	]
]

var current_wave = null

onready var grid : Grid = find_parent("Game").find_node("Grid")
onready var container: YSort = $Virus
onready var timer: Timer = $Timer


func _ready() -> void:
	timer.connect("timeout", self, "_on_Timer_timeout")
	
	current_wave = waves.pop_front()
	if not current_wave.empty():
		timer.start(current_wave[0].wait)

func _on_Timer_timeout():
	var wave = current_wave.pop_front()
	_spawn_wavelet(wave)
	
	if current_wave.empty():
		print("wave finished")
	else:
		timer.start(current_wave[0].wait)

func _spawn_wavelet(wave):
	assert(wave.virus.size() <= int(grid.size.y))
	
	var possible_rows = _get_possible_rows()
		
	for i in wave.virus:
		var virus = -1
		var row = -1
		
		if i is int:
			virus = i	
		else:
			virus = i.virus
			if row in i:
				row = i.row
		
		if row < 0 or row >= grid.size.y:
			row = _get_random(possible_rows)
		
		_spawn(virus, row)
		
		
func _spawn(type: int, row: int):
	var virus = VIRUS[type].instance()
	virus.global_position = grid.grid_to_world(Vector2(0, row))
	container.add_child(virus)


func _get_random(possible_rows: Array) -> int:
	# TODO: check rows
	var i = randi() % possible_rows.size()
	var row = possible_rows[i]
	possible_rows.remove(i)
	return row
	
	
func _get_possible_rows() -> Array:
	return range(0, int(grid.size.y) - 1)
