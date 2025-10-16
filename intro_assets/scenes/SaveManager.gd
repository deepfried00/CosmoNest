# SaveManagerMessGame.gd (or your SaveManager file)
extends Node

const SAVE_PATH = "user://game_data.cfg"
const GAME_STATE_SECTION = "game_state"

var game_data = ConfigFile.new()

# The default color for the sprites.
var default_color = Color(1.0, 1.0, 1.0, 1.0)
var default_background_index: int = 0

# Dictionary to hold the colors of all objects.
var object_colors: Dictionary = {}
var background_index: int

func _ready():
	load_game()

func save_game():
	# Clear the old data before writing the new dictionary
	game_data.clear()
	for key in object_colors.keys():
		game_data.set_value(GAME_STATE_SECTION, key, object_colors[key])
	game_data.set_value(GAME_STATE_SECTION, "background_index", background_index)
	game_data.save(SAVE_PATH)
	print("Game state saved.")

func load_game():
	var error = game_data.load(SAVE_PATH)
	if error == OK:
		var saved_keys = game_data.get_section_keys(GAME_STATE_SECTION)
		for key in saved_keys:
			if key != "background_index":
				object_colors[key] = game_data.get_value(GAME_STATE_SECTION, key)
		background_index = game_data.get_value(GAME_STATE_SECTION, "background_index", default_background_index)
		print("Game state loaded.")
	else:
		print("Save file not found. Using default colors & bg.")
		background_index = default_background_index

func reset_object_data(object_name: String):
	# Set the color for the specific object back to default.
	object_colors[object_name] = default_color
	
	# After updating the dictionary, save the entire state.
	save_game()
	print("Object data for '" + object_name + "' reset to default.")
	
func reset_background_data():
	background_index = default_background_index
	save_game()
	print("Background reset to default.")
