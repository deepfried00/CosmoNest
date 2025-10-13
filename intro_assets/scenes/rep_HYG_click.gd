extends Area2D

@onready var toilet = $newtoilet  # This is the TextureRect popup
@onready var bath = $newshower
@onready var sink = $newsink

func _ready():
	connect("input_event", Callable(self, "_on_click"))
	toilet.visible = false
	bath.visible = false
	sink.visible = false

	

func _on_click(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var clicked_shape = get_child(shape_idx)
		print("Clicked on:", clicked_shape.name)

		match clicked_shape.name:
			"toilet":
				toilet.visible = true
			"shower":
				bath.visible = true
			"sink":
				sink.visible = true
			"tocockpit":
				print("going to cockpit")
				
				Transition.transition_to_scene("res://intro_assets/scenes/cockpitmain.tscn")
			"crew":
				print("going to crew")
				_handle_crew_transition()
				
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
