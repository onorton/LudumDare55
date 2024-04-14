class_name PlacementAgnostic

var items: Array
var locations: Array

func _init(possible_items, possible_locations):
	items = possible_items
	locations = possible_locations

func cartesian_product():
	var possibilities = {}
	for location in locations:
		possibilities[location] = items.duplicate()
	return possibilities
