extends PanelContainer


onready var game = find_parent("Game")


func _on_RestartButton_pressed():
	hide()
	game.restart()	
