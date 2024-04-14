extends Node

signal word_selected(word: String, known: bool)
signal sound_triggered(sound_name: String)

var word_scene = preload ("res://Scenes/word.tscn")

var words = {"Daemon": true,
"Audi": true,
"Meum": false,
"Verbum": true,
"Haec": true,
"Verbera": true,
"Dona": true,
"Accipere": true,
"Exaudi": true,
"Me": true,
"Nunc": true,
"Veni": true,
"De": true,
"Profundis": false,
"Inferni": true,
"Medius": false,
"Metus": false,
"Profero": false}

# Called when the node enters the scene tree for the first time.
func _ready():
	var container = get_node("GridContainer")
	var word_names = words.keys()
	randomize()
	word_names.shuffle()
	for word in word_names:
		var word_instance = word_scene.instantiate()
		word_instance.text = word
		container.add_child(word_instance)
		word_instance.pressed.connect(_on_button_pressed.bind(word))

func _on_button_pressed(word: String):
	word_selected.emit(word, words[word])
	if (words[word]):
		sound_triggered.emit("talking")
	else:
		sound_triggered.emit("talking_question")
