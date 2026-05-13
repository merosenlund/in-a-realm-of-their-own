extends Node

signal mana_changed(new_amount)

var current_mana: float = 0.0
var base_generation_rate: float = 1.0

func _process(delta):
	current_mana += base_generation_rate * delta
	mana_changed.emit(current_mana)
