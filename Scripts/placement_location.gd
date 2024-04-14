class_name PlacementLocation
extends Node

var placed = false

signal item_placed(message: String)

var player_vars

# Called when the node enters the scene tree for the first time.
func _ready():
	player_vars = get_node("/root/PlayerVariables")

var placed_item_scene = preload ("res://Scenes/placed_item.tscn")

func _on_area_2d_mouse_entered():
	pass # Replace with function body.

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		var mouseEvent = event as InputEventMouseButton
		if mouseEvent.button_index == MOUSE_BUTTON_LEFT and !placed and player_vars.selected_item != null:
			var placed_item = placed_item_scene.instantiate()
			var sprite = placed_item.get_node("Sprite2D") as Sprite2D
			sprite.texture = player_vars.selected_item.world_sprite
			sprite.offset = Vector2(0, -sprite.texture.get_height() / 2.0)
			add_child(placed_item)
			placed = true
			print_debug("Placed %s" % player_vars.selected_item.item_name)
			
			item_placed.emit("Place %s at %s" % [player_vars.selected_item.item_name, name])
			player_vars.selected_item.on_placed()
			player_vars.deselect_item()

func on_item_selected():
	if !placed:
		var sprite = get_node("Sprite2D") as Sprite2D
		sprite.visible = true
	
func on_item_deselected():
	var sprite = get_node("Sprite2D") as Sprite2D
	sprite.visible = false