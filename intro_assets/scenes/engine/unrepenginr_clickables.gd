extends Area2D
@onready var note = $note2

func _ready():
	connect("input_event", Callable(self, "_on_click"))
	note.visible = false

	

func _on_click(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var clicked_shape = get_child(shape_idx)
		print("Clicked on:", clicked_shape.name)

		match clicked_shape.name:
			"note":
				note.visible = true
			"mess":
				print("going to mess")
				repair_engine()
				_handle_engine_transition()
			"work":
				print("going to work")
				Transition.transition_to_scene("res://intro_assets/repWork.tscn")
func repair_engine():
	RoomStateManager.set_room_state("engine", true)  # Set the state to repaired
	RoomStateManager.set_room_visited_in_order("engine")  # Mark the room as visited in correct order
	print("engine has been repaired and room state updated.")  
func _handle_engine_transition():
	# Ensure LSS has been repaired before accessing Storage
	if RoomStateManager.get_room_state("lss"):  # Check if LSS is repaired (true)
		if RoomStateManager.get_room_state("storage"):
			if RoomStateManager.get_room_state("kitchen"):
				if RoomStateManager.get_room_state("hygiene"):
					if RoomStateManager.get_room_state("crew"):
						if RoomStateManager.get_room_state("science"):
							if RoomStateManager.get_room_state("engine"):
								if RoomStateManager.can_visit_room_in_order("mess"):
									print("Transitioning to mess room...")  # Debugging line to ensure it's transitioning
			
			# If Storage is repaired (true), transition to the repaired storage scene
									if RoomStateManager.get_room_state("mess"):  # If Storage is repaired (true)
										if not RoomStateManager.has_cutscene_played("mess", "fixed"):
											RoomStateManager.set_cutscene_played("mess", "fixed", true)
											Transition.transition_to_scene("res://intro_assets/scenes/mass/base_mass.tscn")
										else:
											Transition.transition_to_scene("res://intro_assets/scenes/mass/base_mass.tscn")  # Repaired scene (no cutscene)
									else:  # If Storage is still broken (false)
										if not RoomStateManager.has_cutscene_played("mess", "broken"):
											RoomStateManager.set_cutscene_played("mess", "broken", true)
											Transition.transition_to_scene("res://intro_assets/scenes/mass/mess_scene.tscn")
										else:
											Transition.transition_to_scene("res://intro_assets/scenes/mass/base_mass.tscn")  # Unrepaired scene (no cutscene)
			
			# Mark Storage as visited in correct order AFTER the transition
									RoomStateManager.set_room_visited_in_order("mess")
			
			# After repairing Storage, allow access to Kitchen
									RoomStateManager.set_room_visited_in_order("mess") 
								else:
									print("You cannot visit mess yet. Follow the story flow.")
							else:
								print("You cannot access mess until you have repaired engine.")
