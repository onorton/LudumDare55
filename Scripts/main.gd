extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerVariables.reset()

var expected_instructions = ["Place Candle at Placement Location 1",
PlacementAgnostic.new(["Candle"], ["Placement Location 3", "Placement Location 4"]),
"Say Daemon",
"Say Audi",
"Say Meum",
"Say Verbum",
PlacementAgnostic.new(["Orange", "Meat"], ["Placement Location 2", "Placement Location 5"]),
"Say Daemon",
"Say Haec",
"Say Dona",
"Say Accipere",
"Place Skull at Placement Location Centre",
"Say Daemon",
"Say Exaudi",
"Say Me",
"Say Nunc",
"Say Veni",
"Say De",
"Say Profundis",
"Say Inferni"]

func _on_instruction_followed(instruction: String):
	PlayerVariables.instructions.push_back(instruction)
	_check_victory()

func _check_victory():
	print_debug("Checking victory %s %s" % [PlayerVariables.instructions, expected_instructions])
	var num_player_instructions = PlayerVariables.instructions.size()
	if num_player_instructions > 23 or PlayerVariables.instructions[num_player_instructions - 2] == "Say Profundis":
		var i = 0
		var expected_instructions_index = 0
		var success = true
		while expected_instructions_index < expected_instructions.size():
			var instruction = expected_instructions[expected_instructions_index]
			if instruction is String:
				if PlayerVariables.instructions[i] != instruction:
					success = false
					break
				i += 1
				expected_instructions_index += 1
			elif instruction is PlacementAgnostic:
				var possibilities = instruction.cartesian_product()
				var end_of_slice = expected_instructions_index + possibilities.size()
				# Don't have enough instructions
				if end_of_slice > num_player_instructions:
					print_debug("Not enough player instructions left")
					success = false
					break

				var slice = PlayerVariables.instructions.slice(i, end_of_slice)

				for location in possibilities:
					for item in possibilities[location]:
						var index = slice.find("Place %s at %s" % [item, location])
						if index > - 1:
							slice.remove_at(index)

				if slice.size() > 0:
					success = false
				i += possibilities.size()
				expected_instructions_index += 1
				print_debug("Placement agnostic works")
			elif instruction is OrderAgnostic:
				var end_of_slice = expected_instructions_index + instruction.instructions.size()
				# Don't have enough instructions
				if end_of_slice > num_player_instructions:
					success = false
					break

				var slice = PlayerVariables.instructions.slice(i, end_of_slice)
				slice.sort()
				instruction.instructions.sort()

				if slice != instruction.instructions:
					success = false
					break
				expected_instructions_index += 1
				i += instruction.instructions.size()

		var failure_message = "You didn't manage to summon anything."
		if (success):
			await _spawn_at_centre("demon")
			get_node("UI").on_victory()
		else:
			if PlayerVariables.instructions.any(func(x): return x.contains("Cheese")):
				print_debug("Mouse")
				failure_message = "You managed to summon a mouse instead!"
				await _spawn_at_centre("mouse")
			if PlayerVariables.instructions.any(func(x): return x == "Place Skull at Placement Location Centre"):
				print_debug("Abomination")
				failure_message = "You managed to summon an abomination instead!"
				await _spawn_at_centre("abomination")
			get_node("UI").on_game_over(failure_message)

func _spawn_at_centre(sprite_name: String):
	var centre_location = get_node("Placement Locations/Placement Location Centre")
	var placed_item = centre_location.get_node("PlacedItem")
	if placed_item != null:
		placed_item.queue_free()

	var sprite = Sprite2D.new()
	sprite.texture = load("res://Sprites//%s.png" % sprite_name)
	sprite.offset = Vector2(0, -sprite.texture.get_height() / 2.0)
	centre_location.add_child(sprite)
	await get_tree().create_timer(1).timeout
