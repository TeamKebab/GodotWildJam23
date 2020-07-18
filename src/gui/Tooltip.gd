tool
extends PanelContainer


export(Texture) var texture setget _set_texture
export(String) var text setget _set_text


onready var image : TextureRect = find_node("TextureRect")
onready var label : RichTextLabel = find_node("RichTextLabel")


func _ready() -> void:	
	if image != null:
		image.texture = texture
	if label != null:
		label.bbcode_text = text
		
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


func _set_texture(value):
	texture = value
	if image != null:
		image.texture = texture


func _set_text(value):
	text = value
	if label != null:
		label.bbcode_text = text


func _on_Button_pressed():
	queue_free()
	get_tree().set_deferred("paused", false)
