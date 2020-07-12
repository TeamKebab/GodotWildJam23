tool
extends Node2D
class_name MiniBar

export var half_width: int = 30 setget _set_half_width
export var total: float = 2 setget _set_total


export var value: float = total setget _set_value
var bar_width = half_width * 2 - 2

func _ready() -> void:
	_set_half_width(half_width)


func _set_half_width(new_value):
	half_width = new_value
	bar_width = half_width * 2 - 2
	$Start.position.x = - half_width + 0.5
	$End.position.x = half_width - 0.5
	_refresh()

	
func _set_total(new_total):
	total = new_total
	_refresh()
	
	
func _set_value(new_value):
	value = new_value
	_refresh()
	

func _refresh():	
	var pixels_full = floor(value * bar_width / total)
	var pixels_empty = bar_width - pixels_full
	
	if $Full != null and $Empty != null:
		$Full.position.x = pixels_full / 2 - half_width + 1
		$Full.scale.x = pixels_full
		
		$Empty.position.x = half_width - 1 - pixels_empty / 2
		$Empty.scale.x = pixels_empty

