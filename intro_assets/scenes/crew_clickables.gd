extends Area2D

@onready var note = $notee  # This is the TextureRect popup


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

			"hyg":
				print("going to hyg")
				
				Transition.transition_to_scene("res://intro_assets/scenes/repairedHyg.tscn")
			"repair":
				print("repairing")
				repair_crew()
				Transition.transition_to_scene("res://intro_assets/scenes/repaired_crew_scene.tscn")
				
func repair_crew():
	RoomStateManager.set_room_state("crew", true)  # Set the state to repaired
	RoomStateManager.set_room_visited_in_order("crew")  # Mark the room as visited in correct order
	print("crew has been repaired and room state updated.")  # Debugging line
