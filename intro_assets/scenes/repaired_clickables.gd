extends Area2D

@onready var bio = $bio  # This is the clickable CollisionShape2D
@onready var power = $power
@onready var co2 = $co2
@onready var togalley = $togalley
@onready var tocockpit = $tocockpit
@onready var bgm_player = $Gamesound

@onready var algae = $algae  # This is the TextureRect popup
@onready var gen = $gen
@onready var co22 = $co22

func _ready():
	connect("input_event", Callable(self, "_on_click"))
	MusicManager.set_music_state(true)

	# Start with all popups hidden
	algae.visible = false
	gen.visible = false
	co22.visible = false
	bgm_player.play() 

func _on_click(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var clicked_shape = get_child(shape_idx)

		match clicked_shape.name:
			"bio":
				algae.visible = true
			"power":
				gen.visible = true
			"co2":
				co22.visible = true
			"togalley":
				_handle_storage_transition()

			"tocockpit":
				print("Was clicked")
				bgm_player.stop() 
				Transition.transition_to_scene("res://intro_assets/scenes/cockpitmain.tscn")
				
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
