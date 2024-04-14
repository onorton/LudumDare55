extends Node

var selected_item: Item
var paused = false
var first_attempt = true

@export var instructions: Array = []

func reset():
	selected_item = null
	instructions = []
	paused = false

func select_item(item: Item):
	selected_item = item
	get_node("/root/Node2D/Placement Locations").on_item_selected()

func deselect_item():
	selected_item = null
	get_node("/root/Node2D/Placement Locations").on_item_deselected()
