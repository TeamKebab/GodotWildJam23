extends Area2D


var amount: int = 1


onready var collect_sound : AudioStreamPlayer2D = $CollectSound


func _ready() -> void:
	self.connect("input_event", self, "_on_AntiBodies_input_event")


func _on_AntiBodies_input_event(viewport: Viewport, event : InputEvent, shape_idx: int):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == BUTTON_LEFT:			
			if not get_tree().is_input_handled():
				get_tree().set_input_as_handled()
				
				Player.antibodies += amount
				hide()
				
				collect_sound.play()
				
				yield(collect_sound, "finished")
				
				queue_free()
