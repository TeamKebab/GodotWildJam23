extends Area2D

var amount: int = 1


func _ready() -> void:
	self.connect("input_event", self, "_on_AntiBodies_input_event")


func _on_AntiBodies_input_event(viewport: Viewport, event : InputEvent, shape_idx: int):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == BUTTON_LEFT:
			Player.antibodies += amount
			queue_free()
