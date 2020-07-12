extends Label


func _ready() -> void:
	text = str(Player.antibodies)
	Player.connect("antibodies_changed", self, "_on_Player_antibodies_changed")


func _on_Player_antibodies_changed(antibodies: int) -> void:
	text = str(antibodies)
