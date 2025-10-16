extends Area2D

# Define a custom signal that will be emitted when this Area2D is clicked.
signal wall_clicked

func _ready():
	# Connect the built-in input_event signal to the _on_click function.
	connect("input_event", Callable(self, "_on_click"))

func _on_click(viewport, event, shape_idx):
	# Check for a left mouse button press.
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		# Emit the custom signal when the Area2D is clicked.
		emit_signal("wall_clicked")
