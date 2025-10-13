extends Area2D

func _ready():
	connect("input_event", Callable(self, "_on_click"))

# Handle mouse click events
func _on_click(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var clicked_shape = get_child(shape_idx)  # Get the clicked shape
		
		match clicked_shape.name:
			"CollisionShape2D":  # Transition to LSS scene
				_handle_lss_transition()
				
			"storage":  # Transition to the storage scene
				_handle_storage_transition()

			"hyg":  # Transition to hygiene scene
				_handle_hygiene_transition()

# Transition to LSS scene with broken or fixed state logic
func _handle_lss_transition():
	if RoomStateManager.can_visit_room_in_order("lss"):
		print("Transitioning to LSS room...")  # Debugging line to ensure it's transitioning
		
		# Check if LSS is repaired
		if RoomStateManager.get_room_state("lss"):  # If LSS is repaired (true)
			if not RoomStateManager.has_cutscene_played("lss", "fixed"):
				RoomStateManager.set_cutscene_played("lss", "fixed", true)
				Transition.transition_to_scene("res://intro_assets/scenes/repairedLss.tscn")  # Repaired scene
			else:
				Transition.transition_to_scene("res://intro_assets/scenes/repairedLss.tscn")  # Repaired scene
		else:  # If LSS is still broken (false)
			if not RoomStateManager.has_cutscene_played("lss", "broken"):
				RoomStateManager.set_cutscene_played("lss", "broken", true)
				Transition.transition_to_scene("res://intro_assets/scenes/unrep_lss_scene1.tscn")  # Unrepaired scene
			else:
				Transition.transition_to_scene("res://intro_assets/scenes/unrepairedLss.tscn")  # Unrepaired scene
		
		# Mark LSS as visited in correct order AFTER the transition
		RoomStateManager.set_room_visited_in_order("lss")
		
		# After completing LSS, make Storage available
		RoomStateManager.set_room_visited_in_order("storage")  # Make storage available in the correct order
	else:
		print("You cannot visit LSS yet. Follow the story flow.")

# Transition to storage scene with broken or fixed state logic
func _handle_storage_transition():
	# Ensure LSS has been repaired before accessing Storage
	if RoomStateManager.get_room_state("lss"):  # Check if LSS is repaired (true)
		if RoomStateManager.can_visit_room_in_order("storage"):
			print("Transitioning to Storage room...")  # Debugging line to ensure it's transitioning
			
			# If Storage is repaired (true), transition to the repaired storage scene
			if RoomStateManager.get_room_state("storage"):  # If Storage is repaired (true)
				if not RoomStateManager.has_cutscene_played("storage", "fixed"):
					RoomStateManager.set_cutscene_played("storage", "fixed", true)
					Transition.transition_to_scene("res://intro_assets/scenes/storageRepaired.tscn")
				else:
					Transition.transition_to_scene("res://intro_assets/scenes/storageRepaired.tscn")  # Repaired scene (no cutscene)
			else:  # If Storage is still broken (false)
				if not RoomStateManager.has_cutscene_played("storage", "broken"):
					RoomStateManager.set_cutscene_played("storage", "broken", true)
					Transition.transition_to_scene("res://intro_assets/scenes/unrep_storage_scene1.tscn")
				else:
					Transition.transition_to_scene("res://intro_assets/scenes/unrepairedStorage.tscn")  # Unrepaired scene (no cutscene)
			
			# Mark Storage as visited in correct order AFTER the transition
			RoomStateManager.set_room_visited_in_order("storage")
			
			# After repairing Storage, allow access to Kitchen
			RoomStateManager.set_room_visited_in_order("kitchen") 
		else:
			print("You cannot visit Storage yet. Follow the story flow.")
	else:
		print("You cannot access Storage until you have repaired LSS.")

# Transition to hygiene scene with broken or fixed state logic
func _handle_hygiene_transition():
	# Ensure LSS has been repaired before accessing Storage
	if RoomStateManager.get_room_state("lss"):  # Check if LSS is repaired (true)
		if RoomStateManager.get_room_state("storage"):
			if RoomStateManager.get_room_state("kitchen"):
				if RoomStateManager.can_visit_room_in_order("hygiene"):
					print("Transitioning to hygiene room...")  # Debugging line to ensure it's transitioning
			
			# If Storage is repaired (true), transition to the repaired storage scene
					if RoomStateManager.get_room_state("hygiene"):  # If Storage is repaired (true)
						if not RoomStateManager.has_cutscene_played("hygiene", "fixed"):
							RoomStateManager.set_cutscene_played("hygiene", "fixed", true)
							Transition.transition_to_scene("res://intro_assets/scenes/repairedHyg.tscn")
						else:
							Transition.transition_to_scene("res://intro_assets/scenes/repairedHyg.tscn")  # Repaired scene (no cutscene)
					else:  # If Storage is still broken (false)
						if not RoomStateManager.has_cutscene_played("hygiene", "broken"):
							RoomStateManager.set_cutscene_played("hygiene", "broken", true)
							Transition.transition_to_scene("res://intro_assets/scenes/unrepairedHyg_Scene.tscn")
						else:
							Transition.transition_to_scene("res://intro_assets/scenes/unrepairedHyg.tscn")  # Unrepaired scene (no cutscene)
			
			# Mark Storage as visited in correct order AFTER the transition
					RoomStateManager.set_room_visited_in_order("hygiene")
			
			# After repairing Storage, allow access to Kitchen
					RoomStateManager.set_room_visited_in_order("crew") 
				else:
					print("You cannot visit kitchen yet. Follow the story flow.")
			else:
				print("You cannot access kitchen until you have repaired Storage.")
