extends Area2D

@onready var toilet = $oldtoilet  # This is the TextureRect popup
@onready var bath = $oldbath

func _ready():
	connect("input_event", Callable(self, "_on_click"))
	MusicManager.set_music_state(false)
	toilet.visible = false
	bath.visible = false

	

func _on_click(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var clicked_shape = get_child(shape_idx)
		print("Clicked on:", clicked_shape.name)

		match clicked_shape.name:
			"toilet":
				toilet.visible = true
			"bathroom":
				bath.visible = true
			"toCockpit":
				print("going to cockpit")
				
				Transition.transition_to_scene("res://intro_assets/scenes/cockpitmain.tscn")
			"repair":
				print("repairing")
				repair_hyg()
				Transition.transition_to_scene("res://intro_assets/scenes/repairedHyg_Scene.tscn")
				
func repair_hyg():
	RoomStateManager.set_room_state("hygiene", true)  # Set the state to repaired
	RoomStateManager.set_room_visited_in_order("hygiene")  # Mark the room as visited in correct order
	print("HYG has been repaired and room state updated.")  # Debugging line
