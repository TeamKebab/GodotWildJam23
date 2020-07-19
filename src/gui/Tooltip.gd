tool
extends PanelContainer

onready var ok_sound : AudioStreamPlayer = $AudioStreamPlayer


func _ready() -> void:			
	anchor_left = 0.5
	anchor_right = 0.5
	anchor_top = 0.5
	anchor_bottom = 0.5
	var size = get_size()
	margin_left = -size.x / 2
	margin_right = -size.x / 2
	margin_top = -size.y / 2
	margin_bottom = -size.y / 2


func _on_CheckBox_toggled(button_pressed):
	Player.show_tips = not button_pressed


func _on_Button_pressed():
	ok_sound.play()
	get_tree().set_deferred("paused", false)
	hide()
	
	yield(ok_sound, "finished")
	
	queue_free()
