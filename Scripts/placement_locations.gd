class_name PlacementLocations
extends Node2D

func _ready():
	on_item_deselected()

func on_item_selected():
	for child in get_children():
		child.on_item_selected()
		
func on_item_deselected():
	for child in get_children():
		child.on_item_deselected()
