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
					"type": Virus.CUTEVID,
					"row": 0
				}
			]
		},
		{
			"wait": 5,
			"times": 20,
			"virus":[
				Virus.CUTEVID,
				Virus.CUTEVID,
			]
		}
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
	var wave = current_wave[0]
	
	if "times" in wave and wave.times > 1:
		wave.times -= 1
	else:
		current_wave.remove(0)
		
	_spawn_wavelet(wave)
	
	if current_wave.empty():
		print("wave finished")
	else:
		timer.start(current_wave[0].wait)


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
	
	if Player.spot_infected:
		virus.multiplier = 2
	
	virus.global_position = grid.grid_to_world(Vector2(0, row))
	container.add_child(virus)


func _get_random(possible_rows: Array) -> int:
	var i = randi() % possible_rows.size()
	var row = possible_rows[i]
	possible_rows.remove(i)
	return row
	
	
func _get_possible_rows() -> Array:
	return range(0, int(grid.size.y))
