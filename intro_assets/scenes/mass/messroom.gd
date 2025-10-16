extends Area2D

@onready var color_picker =  $CanvasLayer2/Control/ColorPicker
@onready var sprite_to_color = $TextureRect2  # The Sprite2D node you want to change color
@onready var texture_button = $te

var selected_color : Color = Color(1, 1, 1, 1)  # Default color is white

# Called when the node is ready
func _ready():
	# Initially hide the color picker
	color_picker.visible = false

# Called when the Area2D (sprite) is clicked
func _on_click(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var clicked_shape = get_child(shape_idx)
		print("Clicked on:", clicked_shape.name)

		match clicked_shape.name:
			"game":
				color_picker.visible = true
			"mess":
				print("mess was clicke")
			"work":
				print("work was clicked")
			"note":
				print("note was clicked")
# Called when the color is changed in the ColorPicker
func _on_color_picker_color_changed(color: Color) -> void:
	selected_color = color  # Store the selected color
	sprite_to_color.modulate = selected_color  # Apply the color to the sprite

# Optionally, save the color (you can store it in a file or use it as needed)
func _save_selected_color():
	var save_path = "user://saved_color.save"
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	
	if file:
		file.store_var(selected_color)  # Save the selected color
		file.close()
		print("Color saved: ", selected_color)
	else:
		print("Error saving color!")

# Load the saved color (optional, for when you reopen the game)
func _load_saved_color():
	var save_path = "user://saved_color.save"
	var file = FileAccess.open(save_path, FileAccess.READ)
	
	if file:
		var saved_color = file.get_var()  # Load the color
		sprite_to_color.modulate = saved_color  # Apply the loaded color to the sprite
		file.close()
		print("Color loaded: ", saved_color)
	else:
		print("No saved color found, using default.")
