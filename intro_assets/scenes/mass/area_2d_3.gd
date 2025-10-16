extends Area2D

# @onready is used to cache the nodes for later use
@onready var color_picker = $sofa2/CanvasLayer2/Control/ColorPicker # ColorPicker node in the UI
@onready var sprite_to_color = $sofa2 # The sprite node you want to change color
@onready var reset_button = $sofa2/CanvasLayer2/Control/reset # Reset button to reset color
@onready var button = $button # Button to show/hide color picker

var unique_id: String  # Unique identifier for each sprite

# Store the selected color for saving or reapplying later
var selected_color : Color = Color(1.0, 1.0, 1.0, 1.0)  # Default color is white

# Called when the node is ready
func _ready():
	# Use the name of the Area2D node as the unique ID
	unique_id = name
	
	# Connect signals manually
	connect("input_event", Callable(self, "_on_click"))
	color_picker.connect("color_changed", Callable(self, "_on_color_picker_color_changed"))
	reset_button.connect("pressed", Callable(self, "_on_reset_pressed"))
	
	# Initially hide the color picker and reset button
	color_picker.visible = false
	button.visible = false

	# Apply the color from saved data on game start
	apply_color_from_save()

func _input(event: InputEvent) -> void:
	# Check for a mouse click and if the color picker is visible
	# The event is not handled if a UI element (like the color picker) was clicked,
	# so we only process it when it's unhandled input.
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		if color_picker.visible:
			# Get the position of the click
			var click_position = get_viewport().get_mouse_position()
			
			# Check if the click was outside the color picker's rect
			if not color_picker.get_global_rect().has_point(click_position):
				color_picker.visible = false
				
		if button.visible:
			# Get the position of the click
			var click_position = get_viewport().get_mouse_position()
			
			# Check if the click was outside the button's rect
			if not button.get_global_rect().has_point(click_position):
				button.visible = false


# Called when an Area2D (sprite) is clicked
func _on_click(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		# Get the clicked shape
		var clicked_shape = get_child(shape_idx)
		print("Clicked on:", clicked_shape.name)
		
		# Check if the "game" shape is clicked, and trigger the reset
		if clicked_shape.name == "spfa23":
			print("game clicked")
			_on_reset_pressed()

		# If the "gamee" shape is clicked, show the color picker
		if clicked_shape.name == "sofa2":
			print("gamee clicked")
			color_picker.visible = true
			button.visible = true

# Called when the color is changed in the ColorPicker
func _on_color_picker_color_changed(color: Color) -> void:
	# Store the selected color and apply it to the sprite
	selected_color = color
	sprite_to_color.modulate = selected_color
	
	# Save the color in the SaveManager (to persist the color)
	SaveManagerMessGame.object_colors[unique_id] = selected_color
	SaveManagerMessGame.save_game()

# This function applies the color from the saved game data
func apply_color_from_save():
	# Load the color from the SaveManager using the unique ID
	var loaded_color = SaveManagerMessGame.object_colors.get(unique_id, SaveManagerMessGame.default_color)
	sprite_to_color.modulate = loaded_color
	

# This function resets the game data (including the sprite's color)
func _on_reset_pressed():
	print("Reset pressed for:", unique_id)
	# Reset only this object's data
	SaveManagerMessGame.reset_object_data(unique_id)
	apply_color_from_save()
	
	
