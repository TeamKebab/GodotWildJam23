extends Node


enum Defense {
	SNOT_CANNON,
	STICKY_CANNON,
	SNOT_WALL,
	HAIR,
	IDENTIVID,
	DOUBLE_CANNON,
	CATAPULT
}


var buying_defense : Area2D = null


onready var game = find_parent("Game")
onready var grid : Grid = game.find_node("Grid")
onready var defense_container : Node2D = game.find_node("Defenses")
onready var button_container : Container = find_node("ButtonContainer")
onready var game_over_panel : Control = find_node("GameOverPanel")
onready var tutorial: Control = find_node("Tutorial")


onready var buttons = {
	Defense.SNOT_CANNON : button_container.find_node("CannonButton"),
	Defense.STICKY_CANNON : button_container.find_node("StickyButton"),
	Defense.SNOT_WALL : button_container.find_node("WallButton"),
	Defense.HAIR : button_container.find_node("HairButton"),
	Defense.IDENTIVID : button_container.find_node("IdentividButton"),
	Defense.DOUBLE_CANNON : button_container.find_node("DoubleButton"),
	Defense.CATAPULT : button_container.find_node("CatapultButton"),
}

func _ready() -> void:
	Player.connect("game_over", self, "_on_game_over")
	for node in button_container.get_children():
		if node is BuyButton:
			node.connect("pressed", self, "_on_BuyButton_pressed", [node])


func show_button(defense):
	buttons[defense].show()


func show_tooltip(Tooltip):
	if not Player.show_tips:
		return

	var tooltip = Tooltip.instance()
	tutorial.add_child(tooltip)
	get_tree().paused = true


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


func _on_game_over() -> void:
	game_over_panel.show()


func _on_RestartButton_pressed():
	game_over_panel.hide()
	
	for node in button_container.get_children():
		if node is BuyButton:
			node.hide()
	
	game.restart()	
