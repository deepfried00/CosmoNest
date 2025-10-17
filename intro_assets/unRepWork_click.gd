extends Area2D


func _ready():
	connect("input_event", Callable(self, "_on_click"))
	MusicManager.set_music_state(false)

	

func _on_click(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var clicked_shape = get_child(shape_idx)
		print("Clicked on:", clicked_shape.name)

		match clicked_shape.name:

			"engine":
				print("going to engine")
				
				Transition.transition_to_scene("res://intro_assets/scenes/")
			"crew":
				print("going to crew")
				Transition.transition_to_scene("res://intro_assets/scenes/repairedCrew.tscn")
			"repair":
				print("repair")
				repair_work()
				Transition.transition_to_scene("res://intro_assets/repWork_scene.tscn")
				
				
func repair_work():
	RoomStateManager.set_room_state("science", true)  # Set the state to repaired
	RoomStateManager.set_room_visited_in_order("science")  # Mark the room as visited in correct order
	print("science has been repaired and room state updated.")  # Debugging line
