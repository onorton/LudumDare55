extends TextureRect

var left_page_text: RichTextLabel
var right_page_text: RichTextLabel
var right_page: TextureRect

signal sound_triggered(sound_name: String)

var current_index = 0

var instructions = ["How to summon a demon\n\n1. Place a candle on the point closest to you\n2. Place two candles on the points that follow from where you placed the first candle",
"3. Say the following words\n\nDaemon Audi Me\nVerbum",
"4. Place two offerings on the other two points of the pentagram. Careful not to choose anything that is processed.",
"5. Say the following words\n\nDaemon Haec Dona Accipere",
"6. Place the bones of a man at the centre of the pentagram.",
"7. Finally, say the following words\n\nDaemon Exaudi Me Nunc Et Veni De Prof\nInferni"]

var right_page_textures = ["ripped_right_page_1", "intact_right_page", "ripped_right_page_2"]

# Called when the node enters the scene tree for the first time.
func _ready():
	left_page_text = get_node("Left Page Text")
	right_page_text = get_node("Right Page Text")
	right_page = get_node("Right Page")
	right_page.texture = load("res://Sprites//%s.png" % right_page_textures[current_index])

	if instructions.size() % 2 == 1:
		instructions.push_back("")

	left_page_text.text = instructions[2 * current_index]
	right_page_text.text = instructions[2 * current_index + 1]
	pass # Replace with function body.

func _on_turn_to_next_page():
	if current_index < instructions.size() / 2 - 1:
		current_index += 1
		sound_triggered.emit("turning_page")
	else:
		sound_triggered.emit("error")

	left_page_text.text = instructions[2 * current_index]
	right_page_text.text = instructions[2 * current_index + 1]
	right_page.texture = load("res://Sprites//%s.png" % right_page_textures[current_index])

func _on_turn_to_previous_page():
	if current_index > 0:
		current_index -= 1
		sound_triggered.emit("turning_page")
	else:
		sound_triggered.emit("error")

	left_page_text.text = instructions[2 * current_index]
	right_page_text.text = instructions[2 * current_index + 1]
	right_page.texture = load("res://Sprites//%s.png" % right_page_textures[current_index])

func _on_book_icon_pressed():
	visible = !visible
	sound_triggered.emit("place_item")
