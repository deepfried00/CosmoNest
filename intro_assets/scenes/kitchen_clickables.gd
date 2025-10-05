extends Area2D

@onready var thenote = $note


func _ready():
	connect("input_event", Callable(self, "_on_click"))
	thenote.visible = false  # Start with note hidden
			# Play BGM
	

func _on_click(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var clicked_shape = get_child(shape_idx)
		print("Clicked on:", clicked_shape.name)

		match clicked_shape.name:
			"thenote":
				print("Showing thenote popup")
				thenote.visible = true
			"lss":
				print("going to lss")
				
				Transition.transition_to_scene("res://intro_assets/scenes/repairedLss.tscn")
			"repair":
				print("repairing")
				Transition.transition_to_scene("res://intro_assets/scenes/kitchenrepaired_scene.tscn")
				
					
