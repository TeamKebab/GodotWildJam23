extends Node

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
	SNOT_WALL,
	HAIR,
	IDENTIVID,
	DOUBLE_CANNON
}


const WAVES = [
	{
		"wait": 0.5,
		"times": 1,
		"virus":[
			{
				"type": Virus.CUTEVID,
				"row": 1
			}
		]
	},
	{
		"wait": 0.1,
		"tooltip": preload("res://src/gui/tutorial/CuteVid.tscn")
	},
	{
		"gui": Defense.SNOT_CANNON
	},
	{
		"wait": 0.1,
		"tooltip": preload("res://src/gui/tutorial/Antibodies1.tscn")
	},
	{
		"wait": 0.1,
		"tooltip": preload("res://src/gui/tutorial/SnotCannon.tscn")
	},
	{
		"wait": 6,
		"tooltip": preload("res://src/gui/tutorial/Antibodies2.tscn")
	},
	{
		"gui": Defense.SNOT_WALL
	},
	{
		"gui": Defense.IDENTIVID
	},
	{
		"wait": 1,
		"spots" : {
			"min_cooldown": 10,
			"max_cooldown": 20,
			"heal_time": 10
		}
	},
	{
		"wait": 5,
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

# WAVE REFERENCE
var wave_reference = [
	# enable a button (immediately)
	{
		"gui": Defense.SNOT_WALL
	},
	# spawn some viruses (specific row)
	{
		"wait": 0.5,# wait 0.5 seconds before spawning
		"times": 1, # repeat this wave 1 time
		"virus":[
			{
				"type": Virus.CUTEVID,
				"row": 1
			},
			{
				"type": Virus.CUTEVID,
				"row": 2
			}
		]
	},
	# spawn some viruses (random rows)
	{
		"wait": 5,  # wait 5 seconds before spawning
		"times": 2, # repeat this wave 2 times
		"virus":[
			Virus.CUTEVID,
			Virus.CUTEVID,
		]
	},
	# show a tooltip and pause
	{
		"wait": 0.1,# wait 0.1 seconds before showing the tooltip
		"tooltip": preload("res://src/gui/tutorial/CuteVid.tscn")
	},
	# start spawning spots
	{
		"wait": 1, 				# wait 1 second before starting the spot spawner
		"spots" : {
			"min_cooldown": 10, # minimum seconds before spawning a new spot (optional)
			"max_cooldown": 20, # maximum seconds before spawning a new spot (optional)
			"heal_time": 10		# stop heal time (optional)
		}
	},
	# spawn some spots
	{
		"wait": 0.5,# wait 0.5 seconds before spawning the spots
		"spots": [
			{
				"x": 0, 		# spawn at this column
				"y": 0, 		# spawn at this row
				"heal_time": 10 # time to heal (optional)
			}
		]
	},
]

var waves_left = []


onready var gui = $GUI
onready var spot_spawner = $SpotSpawner
onready var wave_spawner = $WaveSpawner
onready var antibodies = $AntiBodies
onready var defenses = $Defenses

onready var timer : Timer = $Timer


func _ready() -> void:	
	Player.connect("game_over", self, "_on_game_over")
	Player.connect("restart", self, "_on_restart")
	
	timer.connect("timeout", self, "_on_Timer_timeout")
	wave_spawner.connect("virus_destroyed", self, "_on_wave_destroyed")
	restart()


func restart() -> void:		
	Player.restart()
	
	defenses.restart()
	antibodies.restart()
	wave_spawner.restart()
	spot_spawner.restart()
	
	waves_left = WAVES.duplicate(true)
	_setup_wavelet(waves_left[0])
		
	get_tree().set_deferred("paused", false)


func _on_game_over() -> void:
	timer.stop()	
	get_tree().paused = true


func _on_wave_destroyed() -> void:
	if waves_left.empty():
		Player.game_over()


func _on_Timer_timeout():
	var wave = waves_left[0]
	_trigger_wave(wave)


func _trigger_wave(wave):
	if "times" in wave and wave.times > 1:
		wave.times -= 1
	else:
		waves_left.remove(0)

	_spawn_wavelet(wave)

	if not waves_left.empty():
		_setup_wavelet(waves_left[0])


func _setup_wavelet(wave):
	if "wait" in wave:
		timer.start(wave.wait)
	else:
		_trigger_wave(wave)


func _spawn_wavelet(wave):
	if "virus" in wave:
		wave_spawner.spawn_virus(wave.virus)
	
	if "spots" in wave:
		if wave.spots is Array:
			spot_spawner.spawn(wave.spots)
		else:
			if "min_cooldown" in wave.spots:
				spot_spawner.min_seconds = wave.spots.min_cooldown
			if "max_cooldown" in wave.spots:
				spot_spawner.max_seconds = wave.spots.max_cooldown
			if "heal_time" in wave.spots:
				spot_spawner.heal_time = wave.spots.heal_time
			
			spot_spawner.start()

	if "gui" in wave:
		gui.show_button(wave.gui)
	
	if "tooltip" in wave:
		gui.show_tooltip(wave.tooltip)