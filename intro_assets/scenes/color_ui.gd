extends Control

@onready var color_picker = $ColorPicker  # The ColorPicker node
@onready var confirm_button = $confirm  # The Confirm Button

var target_sprite : Sprite2D = null  # The sprite that will have its color changed

func _ready():
	# Connect the button click signal to the function
	confirm_button.connect("pressed", self, "_on_confirm_button_pressed")  # Correct connection

# This function will be called when the "Confirm" button is clicked
func _on_confirm_button_pressed():
	var selected_color = color_picker.color  # Get the selected color from the color picker
	print("Selected Color: ", selected_color)
	
	# Apply the color to the target sprite
	if target_sprite:
		target_sprite.modulate = selected_color  # Change the sprite color
	
	# Optionally, close the color picker UI after confirmation
	queue_free()  # Free the Color Picker UI (or hide it if you want to keep it open)

# This function allows other scenes to pass a sprite to apply the color to
func set_target_sprite(sprite : Sprite2D):
	target_sprite = sprite
