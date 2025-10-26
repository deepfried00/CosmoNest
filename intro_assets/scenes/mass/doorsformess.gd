extends Area2D
@onready var note = $note2

func _ready():
	connect("input_event", Callable(self, "_on_click"))
	note.visible = false

	

func _on_click(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var clicked_shape = get_child(shape_idx)
		print("Clicked on:", clicked_shape.name)

		match clicked_shape.name:
			"note":
				var current_scene = "res://intro_assets/scenes/mass/mass_Entry_scene.tscn"
				if current_scene:
					Engine.set_meta("previous_scene", current_scene)

				# Transition to note cutscene
				print("📝 Opening note cutscene...")
				note.visible = true
				Transition.transition_to_scene("res://intro_assets/scenes/mass/note_cutScene.tscn")
			"engine":
				print("going to erer")
				Transition.transition_to_scene("res://intro_assets/scenes/engine/engine.tscn")

			
