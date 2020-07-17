extends "res://src/entities/Defense.gd"


func _ready():
	self.connect("hp_changed", self, "_on_hp_changed")


func _on_hp_changed(old_hp, new_hp):
	sprite.frame = 1
