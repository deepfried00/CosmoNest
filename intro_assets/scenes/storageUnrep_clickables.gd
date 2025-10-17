extends Area2D

func _ready():
	connect("input_event", Callable(self, "_on_click"))
	MusicManager.set_music_state(false)

# Handle mouse click events
func _on_click(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var clicked_shape = get_child(shape_idx)
		print("Clicked on:", clicked_shape.name)

		match clicked_shape.name:
			"toCockpit":
				print("Going to Cockpit")
				Transition.transition_to_scene("res://intro_assets/scenes/cockpitmain.tscn")

			"repair":  # When the player clicks on the repair object
				print("Repairing Storage...")

				# Update the room state to repaired
				repair_storage()

				# Transition to the repaired storage scene
				Transition.transition_to_scene("res://intro_assets/scenes/repaired_storage_Scene1.tscn")

# Repair the Storage and update the room state
func repair_storage():
	RoomStateManager.set_room_state("storage", true)  # Set the state to repaired
	RoomStateManager.set_room_visited_in_order("storage")  # Mark the room as visited in correct order
	print("Storage has been repaired and room state updated.")  # Debugging line
