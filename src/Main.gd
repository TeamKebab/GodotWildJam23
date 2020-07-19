extends Node

const Virus = Player.Virus
const Defense = Player.Defense

const WAVES = [
	{
		"wait": 0.1,
		"tooltip": preload("res://src/gui/tutorial/Welcome.tscn")
	},
	{
		"gui": Defense.SNOT_CANNON
	},
	{
		"wait": 1,
		"times": 1,
		"virus":[
			{
				"type": Virus.CUTEVID
			}
		]
	},
	{
		"wait": 7,
		"times": 1,
		"virus":[
			{
				"type": Virus.CUTEVID
			}
		]
	},
	{
		"wait": 5,
		"times": 1,
		"virus":[
			{
				"type": Virus.CUTEVID
			}
		]
	},
	{
		"wait": 10,
		"times": 1,
		"virus":[
			{
				"type": Virus.OGREVID,
				"row": 2
			}
		]
	},
	{
		"wait": 0.1,
		"tooltip": preload("res://src/gui/tutorial/Ogrevid.tscn")
	},
	{
		"gui": Defense.STICKY_CANNON
	},
	{
		"wait": 5,
		"times": 2,
		"virus":[
			Virus.CUTEVID,
		]
	},	
	{
		"wait": 8,
		"times": 1,
		"virus":[
			{
				"type": Virus.OGREVID,
				"row": 2
			},
			{
				"type": Virus.OGREVID,
				"row": 5
			}
		]
	},
	{
		"gui": Defense.SNOT_WALL
	},
	{
		"tooltip": preload("res://src/gui/tutorial/MoreOgrevid.tscn")
	},
	{
		"wait": 10,
		"times": 1,
		"virus":[
			{
				"type": Virus.OGREVID
			},
			{
				"type": Virus.CUTEVID
			},
			{
				"type": Virus.CUTEVID
			}
		]
	},
	{
		"wait": 15,
		"times": 1,
		"virus":[
			{
				"type": Virus.CUTEVID
			},
			{
				"type": Virus.CUTEVID
			},
			{
				"type": Virus.CUTEVID
			},
			{
				"type": Virus.CUTEVID
			},
			{
				"type": Virus.CUTEVID
			},
			{
				"type": Virus.CUTEVID
			},
		]
	},
	{
		"wait": 1,
		"spots" : {
			"min_cooldown": 15,
			"max_cooldown": 25,
			"heal_time": 10
		}
	},
	{
		"tooltip": preload("res://src/gui/tutorial/SoreSpots.tscn")
	},
	{
		"gui": Defense.HAIR
	},
	{
		"wait": 5,
		"times": 1,
		"virus":[
			{
				"type": Virus.OGREVID,
				"row":4
			},
		]
	},
	{
		"wait": 3,
		"times": 1,
		"virus":[
			{
				"type": Virus.OGREVID,
				"row":6
			},
		]
	},
	{
		"wait": 3,
		"times": 1,
		"virus":[
			{
				"type": Virus.OGREVID,
				"row":2
			},
		]
	},
	{
		"wait": 2,
		"times": 1,
		"virus":[
			{
				"type": Virus.OGREVID,
				"row":4
			},
		]
	},
	{
		"wait": 2,
		"times": 1,
		"virus":[
			{
				"type": Virus.OGREVID,
				"row":6
			},
		]
	},
	{
		"wait": 2,
		"times": 1,
		"virus":[
			{
				"type": Virus.OGREVID,
				"row":2
			},
		]
	},
	{
		"wait": 15,
		"tooltip": preload("res://src/gui/tutorial/Ghostvid.tscn")
	},
	{
		"gui": Defense.IDENTIVID
	},
	{
		"wait": 3,
		"times": 1,
		"virus":[
			{
				"type": Virus.CUTEVID
			},
			{
				"type": Virus.CUTEVID
			},
			{
				"type": Virus.CUTEVID
			},
		]
	},
	{
		"wait": 5,
		"times": 1,
		"virus":[
			{
				"type": Virus.GHOSTVID,
				"row":3
			},
		]
	},
	{
		"wait": 10,
		"times": 1,
		"virus":[
			{
				"type": Virus.GHOSTVID
			},
		]
	},	{
		"wait": 2,
		"times": 1,
		"virus":[
			{
				"type": Virus.OGREVID,
				"row":4
			},
		]
	},
	{
		"wait": 7,
		"times": 1,
		"virus":[
			{
				"type": Virus.GHOSTVID
			},
		]
	},
	{
		"wait": 2,
		"times": 1,
		"virus":[
			{
				"type": Virus.OGREVID,
				"row":6
			},
		]
	},
	{
		"wait": 10,
		"tooltip": preload("res://src/gui/tutorial/Firevid.tscn")
	},
	{
		"wait": 2,
		"times": 1,
		"virus":[
			{
				"type": Virus.OGREVID,
				"row":2
			},
		]
	},
	{
		"wait": 2,
		"times": 1,
		"virus":[
			{
				"type": Virus.FIREVID,
				"row":3
			},
		]
	},
	{
		"wait": 3,
		"times": 1,
		"virus":[
			{
				"type": Virus.GHOSTVID,
				"row":6
			},
		]
	},
	{
		"wait": 5,
		"times": 1,
		"virus":[
			{
				"type": Virus.FIREVID,
				"row":3
			},
		]
	},
	{
		"wait": 2,
		"times": 1,
		"virus":[
			{
				"type": Virus.OGREVID
			},
		]
	},
	{
		"wait": 5,
		"times": 1,
		"virus":[
			{
				"type": Virus.FIREVID
			},
		]
	},
	{
		"wait": 2,
		"times": 1,
		"virus":[
			{
				"type": Virus.OGREVID
			},
		]
	},
	{
		"wait": 5,
		"times": 1,
		"virus":[
			{
				"type": Virus.FIREVID
			},
		]
	},
	{
		"wait": 3,
		"times": 1,
		"virus":[
			{
				"type": Virus.GHOSTVID
			},
		]
	},
		{
		"wait": 2,
		"times": 1,
		"virus":[
			{
				"type": Virus.OGREVID
			},
		]
	},
	{
		"wait": 15,
		"tooltip": preload("res://src/gui/tutorial/Queenvid.tscn")
	},
	{
		"gui": Defense.DOUBLE_CANNON
	},
	{
		"wait": 3,
		"times": 1,
		"virus":[
			{
				"type": Virus.QUEENVID,
				"row":3
			},
		]
	},
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
		"tooltip": preload("res://src/gui/tutorial/Welcome.tscn")
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
onready var music : AudioStreamPlayer2D = $Music


func _ready() -> void:	
	Player.connect("game_over", self, "_on_game_over")
	
	timer.connect("timeout", self, "_on_Timer_timeout")
	wave_spawner.connect("virus_destroyed", self, "_on_wave_destroyed")
	restart()


func restart() -> void:		
	Player.restart()
	
	defenses.restart()
	antibodies.restart()
	wave_spawner.restart()
	spot_spawner.restart()
	gui.restart()
	
	music.play(0)
	
	waves_left = WAVES.duplicate(true)
	_setup_wavelet(waves_left[0])
		
	get_tree().set_deferred("paused", false)


func _on_game_over() -> void:
	end_game()


func end_game():
	timer.stop()	
	music.stop()
	get_tree().paused = true


func _on_wave_destroyed() -> void:
	if waves_left.empty():
		end_game()
		gui.win()


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
