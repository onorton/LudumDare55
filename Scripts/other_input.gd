extends Control

var player_vars

# Called when the node enters the scene tree for the first time.
func _ready():
	player_vars = get_node("/root/PlayerVariables")

func _input(event):
		if event is InputEventMouseButton:
			var mouseEvent = event as InputEventMouseButton
			if mouseEvent.button_index == MOUSE_BUTTON_LEFT:
				# Cast to make sure there isn't anything pickable in the way
				var query = PhysicsRayQueryParameters2D.create(event.position, Vector2(event.position.x + 1, event.position.y + 1))
				query.collide_with_areas = true
				query.hit_from_inside = true
				var space_state = get_world_2d().direct_space_state

				var result = space_state.intersect_ray(query)
			
				if result.is_empty():
					player_vars.deselect_item()
