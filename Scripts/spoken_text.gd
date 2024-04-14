extends RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

signal incantation_finished(instruction: String)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _set_spoken_text(word: String, known: bool):
	var extra = "..." if known else "?"
	text = "[center]\"%s%s\"[/center]" % [word, extra]
	visible = true
	get_parent().get_parent().get_node("Blocker").visible = true
	await get_tree().create_timer(1).timeout
	get_parent().get_parent().get_node("Blocker").visible = false
	visible = false
	incantation_finished.emit("Say %s" % word)
