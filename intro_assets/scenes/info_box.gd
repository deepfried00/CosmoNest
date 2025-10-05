extends TextureRect

@onready var text_label := get_node("CanvasLayer2/Control/RichTextLabel")

func _ready():
	mouse_filter = Control.MOUSE_FILTER_STOP
	text_label.visible = true  # Make sure it's visible initially

func _gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		self.visible = false         # Hide the popup
		text_label.visible = false   # Hide the text only (don't clear!)
