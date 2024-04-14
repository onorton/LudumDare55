extends Node

var player_vars

signal sound_triggered(sound_name: String)

# Called when the node enters the scene tree for the first time.
func _ready():
	player_vars = get_node("/root/PlayerVariables")
	if player_vars.first_attempt:
		get_node("Menus/Welcome").visible = true
		get_node("Blocker").visible = true
		player_vars.first_attempt = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_try_again():
	get_tree().reload_current_scene()

func _on_start():
	get_node("Menus/Welcome").visible = false
	get_node("Blocker").visible = false

func _on_quit():
	get_tree().quit()

func on_game_over(failure_message: String):
	get_node("Menus/Game Over").visible = true
	get_node("Menus/Game Over/MarginContainer/VBoxContainer/Message").text = "[center]%s[/center]" % failure_message
	get_node("Blocker").visible = true
	sound_triggered.emit("game_over")

func on_victory():
	get_node("Menus/Victory").visible = true
	get_node("Blocker").visible = true
	sound_triggered.emit("victory")

func _input(event):
	if event is InputEventKey and event.keycode == Key.KEY_ESCAPE and event.is_pressed():
		get_node("Menus/Paused").visible = !player_vars.paused
		player_vars.paused = !player_vars.paused
