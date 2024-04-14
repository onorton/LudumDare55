class_name Item
extends Node
signal trigger_sound(message: String)

@export var world_sprite: Texture2D
@export var item_name: String

var player_vars

# Called when the node enters the scene tree for the first time.
func _ready():
	player_vars = get_node("/root/PlayerVariables")

func _on_gui_input(event: InputEvent):
	if event is InputEventMouseButton:
		var mouse_event = event as InputEventMouseButton
		if mouse_event.button_index == MOUSE_BUTTON_LEFT:
			print_debug("Selected object")
			player_vars.select_item(self)

func on_placed():
	trigger_sound.emit("place_item")
	self.queue_free()
