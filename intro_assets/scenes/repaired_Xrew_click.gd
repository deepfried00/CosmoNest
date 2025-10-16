extends Area2D


func _ready():
	connect("input_event", Callable(self, "_on_click"))


	

func _on_click(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var clicked_shape = get_child(shape_idx)
		print("Clicked on:", clicked_shape.name)

		match clicked_shape.name:
			"hyg":
				print("going to hyg")
				
				Transition.transition_to_scene("res://intro_assets/scenes/repairedHyg.tscn")
			"storage":
				print("going to storage")
				Transition.transition_to_scene("res://intro_assets/scenes/storageRepaired.tscn")
			"research":
				print("going to research")
				_handle_storage_transition()				
					
func _handle_storage_transition():
	# Ensure LSS has been repaired before accessing Storage
	if RoomStateManager.get_room_state("lss"):  # Check if LSS is repaired (true)
		if RoomStateManager.get_room_state("storage"):
			if RoomStateManager.get_room_state("kitchen"):
				if RoomStateManager.get_room_state("hygiene"):
					if RoomStateManager.get_room_state("crew"):
						if RoomStateManager.can_visit_room_in_order("science"):
							print("Transitioning to science room...")  # Debugging line to ensure it's transitioning
			
			# If Storage is repaired (true), transition to the repaired storage scene
							if RoomStateManager.get_room_state("science"):  # If Storage is repaired (true)
								if not RoomStateManager.has_cutscene_played("science", "fixed"):
									RoomStateManager.set_cutscene_played("science", "fixed", true)
									Transition.transition_to_scene("res://intro_assets/repWork.tscn")
								else:
									Transition.transition_to_scene("res://intro_assets/repWork.tscn")  # Repaired scene (no cutscene)
							else:  # If Storage is still broken (false)
								if not RoomStateManager.has_cutscene_played("science", "broken"):
									RoomStateManager.set_cutscene_played("science", "broken", true)
									Transition.transition_to_scene("res://intro_assets/unrepWork_scene.tscn")
								else:
									Transition.transition_to_scene("res://intro_assets/unrepWork.tscn")  # Unrepaired scene (no cutscene)
			
			# Mark Storage as visited in correct order AFTER the transition
							RoomStateManager.set_room_visited_in_order("science")
			
			# After repairing Storage, allow access to Kitchen
							RoomStateManager.set_room_visited_in_order("engine") 
						else:
							print("You cannot visit science yet. Follow the story flow.")
					else:
						print("You cannot access science until you have repaired crew.")
