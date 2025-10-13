extends Area2D

@onready var bgm_player = $Gamesound

func _ready():
	connect("input_event", Callable(self, "_on_click"))

	# Start the background music
	bgm_player.play()

# Handle mouse click events
func _on_click(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var clicked_shape = get_child(shape_idx)  # Get the clicked shape
		
		match clicked_shape.name:
			"tocockpit":
				Transition.transition_to_scene("res://intro_assets/scenes/cockpitmain.tscn")
				bgm_player.stop()
			"crew":
				print("Crew was clicked")
				bgm_player.stop()
				_handle_crew_transition()
			"galley":
				print("Galley was clicked")
				bgm_player.stop()
				_handle_storage_transition()
func _handle_storage_transition():
	# Ensure LSS has been repaired before accessing Storage
	if RoomStateManager.get_room_state("lss"):  # Check if LSS is repaired (true)
		if RoomStateManager.get_room_state("storage"):
			if RoomStateManager.can_visit_room_in_order("kitchen"):
				print("Transitioning to kitchen room...")  # Debugging line to ensure it's transitioning
			
			# If Storage is repaired (true), transition to the repaired storage scene
				if RoomStateManager.get_room_state("kitchen"):  # If Storage is repaired (true)
					if not RoomStateManager.has_cutscene_played("kitchen", "fixed"):
						RoomStateManager.set_cutscene_played("kitchen", "fixed", true)
						Transition.transition_to_scene("res://intro_assets/scenes/kitchenrepaired.tscn")
					else:
						Transition.transition_to_scene("res://intro_assets/scenes/kitchenrepaired.tscn")  # Repaired scene (no cutscene)
				else:  # If Storage is still broken (false)
					if not RoomStateManager.has_cutscene_played("kitchen", "broken"):
						RoomStateManager.set_cutscene_played("kitchen", "broken", true)
						Transition.transition_to_scene("res://intro_assets/scenes/theungalley_scene1.tscn")
					else:
						Transition.transition_to_scene("res://intro_assets/scenes/theungalley.tscn")  # Unrepaired scene (no cutscene)
			
			# Mark Storage as visited in correct order AFTER the transition
				RoomStateManager.set_room_visited_in_order("kitchen")
			
			# After repairing Storage, allow access to Kitchen
				RoomStateManager.set_room_visited_in_order("hygiene") 
			else:
				print("You cannot visit kitchen yet. Follow the story flow.")
		else:
			print("You cannot access kitchen until you have repaired Storage.")

func _handle_crew_transition():
	# Ensure LSS has been repaired before accessing Storage
	if RoomStateManager.get_room_state("lss"):  # Check if LSS is repaired (true)
		if RoomStateManager.get_room_state("storage"):
			if RoomStateManager.get_room_state("kitchen"):
				if RoomStateManager.get_room_state("hygiene"):
					if RoomStateManager.can_visit_room_in_order("crew"):
						print("Transitioning to crew room...")  # Debugging line to ensure it's transitioning
			
			# If Storage is repaired (true), transition to the repaired storage scene
						if RoomStateManager.get_room_state("crew"):  # If Storage is repaired (true)
							if not RoomStateManager.has_cutscene_played("crew", "fixed"):
								RoomStateManager.set_cutscene_played("crew", "fixed", true)
								Transition.transition_to_scene("res://intro_assets/scenes/repairedCrew.tscn")
							else:
								Transition.transition_to_scene("res://intro_assets/scenes/repairedCrew.tscn")  # Repaired scene (no cutscene)
						else:  # If Storage is still broken (false)
							if not RoomStateManager.has_cutscene_played("crew", "broken"):
								RoomStateManager.set_cutscene_played("crew", "broken", true)
								Transition.transition_to_scene("res://intro_assets/scenes/unrepairedCrew_Scene.tscn")
							else:
								Transition.transition_to_scene("res://intro_assets/scenes/unrepairedCrew.tscn")  # Unrepaired scene (no cutscene)
			
			# Mark Storage as visited in correct order AFTER the transition
						RoomStateManager.set_room_visited_in_order("crew")
			
			# After repairing Storage, allow access to Kitchen
						RoomStateManager.set_room_visited_in_order("science") 
					else:
						print("You cannot visit crew yet. Follow the story flow.")
				else:
					print("You cannot access crew until you have repaired Storage.")
