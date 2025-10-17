extends Area2D
@onready var bgm_player = $Gamesound
@onready var note = $TextureRect

func _ready():
	connect("input_event", Callable(self, "_on_click"))
	MusicManager.set_music_state(true)
	# Start with all popups hidden
	note.visible = false
	bgm_player.play() 

func _on_click(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var clicked_shape = get_child(shape_idx)

		match clicked_shape.name:
			"lss":
				Transition.transition_to_scene("res://intro_assets/scenes/repairedLss.tscn")
				bgm_player.stop() 
			"engine":
				print("engine was clicked")
				note.visible = true
			"storage":
				print("storage was clicked")
				bgm_player.stop() 
				Transition.transition_to_scene("res://intro_assets/scenes/storageRepaired.tscn")						
func _handle_engine_transition():
	# Ensure LSS has been repaired before accessing Storage
	if RoomStateManager.get_room_state("lss"):  # Check if LSS is repaired (true)
		if RoomStateManager.get_room_state("storage"):
			if RoomStateManager.get_room_state("kitchen"):
				if RoomStateManager.get_room_state("hygiene"):
					if RoomStateManager.get_room_state("crew"):
						if RoomStateManager.get_room_state("science"):
							if RoomStateManager.can_visit_room_in_order("engine"):
								print("Transitioning to engine room...")  # Debugging line to ensure it's transitioning
			
			# If Storage is repaired (true), transition to the repaired storage scene
								if RoomStateManager.get_room_state("engine"):  # If Storage is repaired (true)
									if not RoomStateManager.has_cutscene_played("engine", "fixed"):
										RoomStateManager.set_cutscene_played("engine", "fixed", true)
										Transition.transition_to_scene("res://intro_assets/scenes/engine/engine.tscn")
									else:
										Transition.transition_to_scene("res://intro_assets/scenes/engine/engine.tscn")  # Repaired scene (no cutscene)
								else:  # If Storage is still broken (false)
									if not RoomStateManager.has_cutscene_played("engine", "broken"):
										RoomStateManager.set_cutscene_played("engine", "broken", true)
										Transition.transition_to_scene("res://intro_assets/scenes/engine/engine_scene.tscn")
									else:
										Transition.transition_to_scene("res://intro_assets/scenes/engine/engine.tscn")  # Unrepaired scene (no cutscene)
			
			# Mark Storage as visited in correct order AFTER the transition
								RoomStateManager.set_room_visited_in_order("engine")
			
			# After repairing Storage, allow access to Kitchen
								RoomStateManager.set_room_visited_in_order("engine") 
							else:
								print("You cannot visit engine yet. Follow the story flow.")
						else:
							print("You cannot access engine until you have repaired science.")
