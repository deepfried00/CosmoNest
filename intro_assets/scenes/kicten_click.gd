extends Area2D
@onready var bgm_player = $Gamesound

func _ready():
	connect("input_event", Callable(self, "_on_click"))

	# Start with all popups hidden

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
				bgm_player.stop() 
				Transition.transition_to_scene("res://intro_assets/scenes/")
			"storage":
				print("storage was clicked")
				bgm_player.stop() 
				Transition.transition_to_scene("res://intro_assets/scenes/storageRepaired.tscn")						
