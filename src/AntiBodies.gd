extends Node2D


func _ready():
	Player.connect("game_over", self, "_on_game_over")


func _on_game_over() -> void:
	for defense in get_children():
		defense.queue_free()
