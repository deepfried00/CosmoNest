extends Area2D

func _ready():
	connect("input_event", Callable(self, "_on_click"))
	MusicManager.set_music_state(true)
	

func _on_click(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var clicked_shape = get_child(shape_idx)
		print("Clicked on:", clicked_shape.name)

		if clicked_shape.name == "earth":
				print("going to yes")
				Transition.transition_to_scene("website")
