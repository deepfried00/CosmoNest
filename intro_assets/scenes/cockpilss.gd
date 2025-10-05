extends Area2D


func _ready():
	connect("input_event", Callable(self, "_on_click"))

func _on_click(viewport, event, shape_idx):

		
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var clicked_shape = get_child(shape_idx)

		match clicked_shape.name:
			"CollisionShape2D":
				Transition.transition_to_scene("res://intro_assets/scenes/unrep_lss_scene1.tscn")
				
			"storage":
				Transition.transition_to_scene("res://intro_assets/scenes/storageRepaired.tscn")
			"hyg":
				Transition.transition_to_scene("res://intro_assets/scenes/unrepairedHyg_Scene.tscn")
				
				
