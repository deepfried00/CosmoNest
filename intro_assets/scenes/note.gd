extends Area2D

@onready var note = $note2  # This is the TextureRect popup

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
			"ending":
				print("ending")
				Transition.transition_to_scene("res://intro_assets/scenes/ending.tscn")
			
				
					
