extends TextureRect

func _ready():
	mouse_filter = Control.MOUSE_FILTER_STOP
	visible = false  # Start hidden

func _gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		visible = false  # Hide when clicked again
