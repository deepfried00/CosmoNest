#extends Area2D
#@onready var color_picker = $sofa2/CanvasLayer2/Control/ColorPicker # ColorPicker node in the UI
#@onready var sprite_to_color = $sofa2 # ColorPicker node in the UI
#@onready var reset_button = $sofa2/CanvasLayer2/Control/reset
#@onready var button = $button
#var selected_color : Color = Color(1.0, 1.0, 1.0, 1.0)  # Default color is white
#
#func _ready():
	#connect("input_event", Callable(self, "_on_click"))
	## Connect the color_changed signal from the color picker to your function
	#color_picker.connect("color_changed", Callable(self, "_on_color_picker_color_changed"))
	#reset_button.connect("pressed", Callable(self, "_on_reset_pressed")) 
#
	#color_picker.visible = false
	#button.visible = false
	#apply_color_from_save()
#
#func _input(event: InputEvent) -> void:
	## Check for a mouse click and if the color picker is visible.
	## The event is not handled if a UI element (like the color picker) was clicked,
	## so we only process it when it's unhandled input.
	#if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		#if color_picker.visible:
			## Get the position of the click
			#var click_position = get_viewport().get_mouse_position()
			#
			## Check if the click was outside the color picker's rect
			#if not color_picker.get_global_rect().has_point(click_position):
				#color_picker.visible = false
		#if button.visible:
			#var click_position = get_viewport().get_mouse_position()
			#
			## Check if the click was outside the color picker's rect
			#if not button.get_global_rect().has_point(click_position):
				#button.visible = false
#
#func _on_click(viewport, event, shape_idx):
	#if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		#var clicked_shape = get_child(shape_idx)
		#print("Clicked on:", clicked_shape.name)
		#if clicked_shape.name =="game":
			#print("clickedd")
			#_on_reset_pressed()
		#if clicked_shape.name =="sofa2":
			#print("clickedd")
			#color_picker.visible = true
			#button.visible = true
#
#func _on_color_picker_color_changed(color: Color) -> void:
	#SaveManagerMessGame.current_color = color
	#selected_color = color  # Store the selected color
	#sprite_to_color.modulate = selected_color  # Apply the color to the sprite (TextureRect2)
	#SaveManagerMessGame.save_game()
	#
#func apply_color_from_save():
	## Set the sprite's color from the data loaded by the SaveManager.
	#sprite_to_color.modulate = SaveManagerMessGame.current_color
#
#
#func _on_reset_pressed():
	#print("reset pressed")
	#SaveManagerMessGame.reset_game_data()
	#apply_color_from_save()
