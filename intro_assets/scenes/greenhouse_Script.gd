extends Area2D

@onready var green = $green  # This is the clickable CollisionShape2D


@onready var greenhouse = $TextureRect  # This is the TextureRect popup

func _ready():
	connect("input_event", Callable(self, "_on_click"))

	# Start with all popups hidden
	greenhouse.visible = false

func _on_click(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var clicked_shape = get_child(shape_idx)

		match clicked_shape.name:
			"green":
				greenhouse.visible = true
