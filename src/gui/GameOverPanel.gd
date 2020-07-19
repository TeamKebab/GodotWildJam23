extends PanelContainer


onready var game = find_parent("Game")
onready var music = $Music

func _on_RestartButton_pressed():
	hide()
	music.stop()
	game.restart()	


func _on_GameOverPanel_visibility_changed():
	if music.playing:
		music.stop()
	else:
		music.play(0)
