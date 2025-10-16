extends Node2D

# Preload your textures. Adjust the paths.
@onready var backgrounds: Array[Texture2D] = [
	preload("res://intro_assets/scenes/mass/Mess room lovely pink 3.png"),
	preload("res://intro_assets/scenes/mass/Mess room leafy abode.png"),
	preload("res://intro_assets/scenes/mass/Mess room wizardy purple 3.png"),
	preload("res://intro_assets/scenes/mass/Mess room def.png")
]

# Reference the TextureRect that will display the background.
@onready var background_texture_rect: TextureRect = $CanvasLayer/TextureRect

func _ready():
	if not is_instance_valid(background_texture_rect):
		print("Error: The 'Background' TextureRect node was not found. Check the node path.")
		return
	
	# Load the background index from the SaveManager on startup
	load_background_from_save()

func change_background():
	if is_instance_valid(background_texture_rect) and not backgrounds.is_empty():
		# Increment the index and update the SaveManager
		SaveManagerMessGame.background_index = (SaveManagerMessGame.background_index + 1) % backgrounds.size()
		
		# Change the texture and save the game state
		background_texture_rect.texture = backgrounds[SaveManagerMessGame.background_index]
		SaveManagerMessGame.save_game()

func load_background_from_save():
	# Set the initial background based on the saved index
	if is_instance_valid(background_texture_rect) and not backgrounds.is_empty():
		var index = SaveManagerMessGame.background_index
		if index >= 0 and index < backgrounds.size():
			background_texture_rect.texture = backgrounds[index]
		else:
			background_texture_rect.texture = backgrounds[SaveManagerMessGame.default_background_index]

func reset_background():
	SaveManagerMessGame.reset_background_data()
	load_background_from_save()

# Signal receiver for when the WallArea is clicked.
func _on_wall_wall_clicked():
	change_background()

# You will need a way to trigger the reset. Add a button and connect its 'pressed' signal to this function.
func _on_reset_background_pressed():
	reset_background()
