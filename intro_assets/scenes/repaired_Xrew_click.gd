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
				Transition.transition_to_scene("res://intro_assets/unrepWork_scene.tscn")				
					
