extends Area2D

@onready var toilet = $newtoilet  # This is the TextureRect popup
@onready var bath = $newshower
@onready var sink = $newsink

func _ready():
	connect("input_event", Callable(self, "_on_click"))
	toilet.visible = false
	bath.visible = false
	sink.visible = false

	

func _on_click(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var clicked_shape = get_child(shape_idx)
		print("Clicked on:", clicked_shape.name)

		match clicked_shape.name:
			"toilet":
				toilet.visible = true
			"shower":
				bath.visible = true
			"sink":
				sink.visible = true
			"tocockpit":
				print("going to cockpit")
				
				Transition.transition_to_scene("res://intro_assets/scenes/cockpitmain.tscn")
			"crew":
				print("going to crew")
				Transition.transition_to_scene("res://intro_assets/scenes/unrepairedCrew_Scene.tscn")
				
					
