extends Virus
class_name Queenvid


const Virus = Player.Virus


const virus_probabilities = {
	Virus.CUTEVID: 20,
	Virus.OGREVID: 10,
	Virus.GHOSTVID: 5,
	Virus.FIREVID: 1,
	Virus.FLYVID: 1
}

export var cooldown_min: float = 3
export var cooldown_max: float = 3

var accumulated_weight: float = 0

onready var spawner = find_parent("WaveSpawner")
onready var spawn_timer = $SpawnTimer


func _ready():
	virus_type = Virus.QUEENVID
	
	spawn_timer.connect("timeout", self, "_on_SpawnTimer_timeout")
	_setup_spawn_timer()

	for virus in virus_probabilities:
		accumulated_weight += virus_probabilities[virus]


func _setup_spawn_timer():
	var timeout = Player.rng.randf_range(cooldown_min, cooldown_max)
	spawn_timer.start(timeout)


func _on_SpawnTimer_timeout():
	var viruses = spawner.spawn_virus([_get_random_virus()])
	
	viruses[0].global_position.x = global_position.x
	
	_setup_spawn_timer()


func _get_random_virus():
	var random = Player.rng.randf_range(0, accumulated_weight)
	var acum = 0
	for virus in virus_probabilities:
		acum += virus_probabilities[virus]
		
		if random < acum:
			return virus
			
	return Virus.CUTEVID
