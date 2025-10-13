extends Area2D

@onready var thenote = $note

func _ready():
	connect("input_event", Callable(self, "_on_click"))
	thenote.visible = false  # Start with note hidden
	# Play BGM

func _on_click(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var clicked_shape = get_child(shape_idx)
		print("Clicked on:", clicked_shape.name)

		match clicked_shape.name:
			"thenote":
				print("Showing thenote popup")
				thenote.visible = true
			"lss":
				print("Going to LSS")
				Transition.transition_to_scene("res://intro_assets/scenes/repairedLss.tscn")
			"repair":
				print("Repairing Kitchen")
				repair_galley()  # Only now mark the kitchen as repaired
				Transition.transition_to_scene("res://intro_assets/scenes/kitchenrepaired_scene.tscn")


func repair_galley():
	RoomStateManager.set_room_state("kitchen", true)  # Set the state to repaired
	RoomStateManager.set_room_visited_in_order("kitchen")  # Mark the room as visited in correct order
	RoomStateManager.set_cutscene_played("kitchen", "repaired", true)  # Mark the repaired cutscene as played
	print("Kitchen has been repaired and room state updated.")
