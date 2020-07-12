extends Button
class_name BuyButton

export(PackedScene) var placeholder_type
var placeholder : Area2D

func _ready():
	Player.connect("antibodies_changed", self, "_on_Player_antibodies_changed")
	placeholder = placeholder_type.instance()
	placeholder.hide()
	add_child(placeholder)
	
	_check_price(Player.antibodies)
	
func _on_Player_antibodies_changed(antibodies: int) -> void:
	_check_price(antibodies)


func _check_price(antibodies: int) -> void:
	disabled = antibodies < placeholder.price
