extends Node2D


signal virus_destroyed

const Virus = Player.Virus

const VIRUS = {
	Virus.CUTEVID : preload("res://src/entities/virus/Cutevid.tscn"),	
	Virus.OGREVID : preload("res://src/entities/virus/Ogrevid.tscn"),
	Virus.GHOSTVID : preload("res://src/entities/virus/Ghostvid.tscn"),
	Virus.FIREVID : preload("res://src/entities/virus/Firevid.tscn"),
	Virus.FLYVID : preload("res://src/entities/virus/Flyvid.tscn"),
	Virus.QUEENVID : preload("res://src/entities/virus/Queenvid.tscn"),
}


onready var grid : Grid = find_parent("Game").find_node("Grid")


func restart() -> void:
	for virus in get_children():
		virus.queue_free()


func _on_virus_destroyed(hurtbox) -> void:
	var virus = hurtbox.get_parent()
	
	remove_child(virus)
	
	var children_left = get_child_count()
	
	if children_left == 0:
		emit_signal("virus_destroyed")


func spawn_virus(viruses):
	assert(viruses.size() <= int(grid.size.y))
	
	var spawned_virus = []
	var possible_rows = _get_possible_rows()
	
	for virus in viruses:
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

		spawned_virus.append(_spawn(virus_type, virus_row))
		
	return spawned_virus	


func _spawn(type: int, row: int):
	var virus = VIRUS[type].instance()

	virus.global_position = grid.grid_to_world(Vector2(0, row))
	virus.win_x = grid.grid_to_world(grid.size).x
	
	add_child(virus)
	virus.connect("destroyed", self, "_on_virus_destroyed")
	
	return virus


func _get_random(possible_rows: Array) -> int:
	var i = Player.rng.randi() % possible_rows.size()
	var row = possible_rows[i]
	possible_rows.remove(i)
	return row


func _get_possible_rows() -> Array:
	return range(0, int(grid.size.y))
