extends Node


var buying_defense : Area2D = null


onready var button_container : Container = find_node("ButtonContainer")
onready var defense_container : Node2D = find_parent("Game").find_node("Defenses")
onready var grid : Grid = $Grid


func _ready() -> void:
	for node in button_container.get_children():
		if node is BuyButton:
			node.connect("pressed", self, "_on_BuyButton_pressed", [node])


func _on_BuyButton_pressed(button : BuyButton) -> void:
	buying_defense = button.placeholder
	
	
func _on_Grid_mouse_entered_cell(cell):
	if buying_defense != null:
		buying_defense.global_position = grid.grid_to_world(cell)
		buying_defense.show()


func _on_Grid_mouse_exited_cell(cell):
	if buying_defense != null:
		buying_defense.hide()


func _on_Grid_mouse_input_cell(event, cell):
	if buying_defense != null and event.pressed and event.button_index == BUTTON_LEFT:
		if _can_place():
			var defense = buying_defense.buy()
			defense_container.add_child(defense)
			buying_defense.hide()
			buying_defense = null
		else:
			print("cannot place")


func _can_place() -> bool:
	if buying_defense == null:
		return false

	var overlapping_bodies = buying_defense.get_overlapping_bodies()
	return overlapping_bodies.empty()
