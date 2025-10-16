extends Node

# Track the state of each room (false = broken, true = fixed)
var room_states = {
	"cockpit": false,
	"lss": false,
	"storage": false,
	"hygiene": false,
	"kitchen": false,
	"crew": false,
	"science": false,
	"engine": false,
	"mess": false
}

# Track if cutscenes have been played for both broken and fixed states
var cutscene_played = {
	"cockpit_broken": false,
	"cockpit_fixed": false,
	"lss_broken": false,
	"lss_fixed": false,
	"storage_broken": false,
	"storage_fixed": false,
	"kitchen_broken": false,
	"kitchen_fixed": false,
	"hygiene_broken": false,
	"hygiene_fixed": false,
	"crew_broken": false,
	"crew_fixed": false,
	"science_broken": false,
	"science_fixed": false,
	"engine_broken": false,
	"engine_fixed": false,
	"mess_broken": false,
	"mess_fixed": false,
	
	# Continue for all rooms
}

# Track room visit order progress (0 = not visited, 1 = visited in order)
var room_progress = {
	"cockpit": 0,  # Cockpit is not required now, so leave it at 0
	"lss": 1,  # LSS is immediately available
	"storage": 0,
	"hygiene": 0,
	"kitchen": 0,
	"crew": 0,
	"science": 0,
	"engine": 0,
	"mess": 1
}

# Set the state of a room (fixed or broken)
func set_room_state(room_name: String, is_fixed: bool):
	room_states[room_name] = is_fixed

# Get the state of a room (fixed or broken)
func get_room_state(room_name: String) -> bool:
	return room_states.get(room_name, false)  # Defaults to broken (false)

# Set cutscene played flag for a specific room state (broken/fixed)
func set_cutscene_played(room_name: String, state: String, has_played: bool):
	cutscene_played[room_name + "_" + state] = has_played

# Check if the cutscene has been played for a specific room state (broken/fixed)
func has_cutscene_played(room_name: String, state: String) -> bool:
	return cutscene_played.get(room_name + "_" + state, false)

# Update room progress when a room is visited in the correct order
func set_room_visited_in_order(room_name: String):
	room_progress[room_name] = 1  # Mark as visited in correct order

# Check if the room is in the correct order for the player to visit
func can_visit_room_in_order(room_name: String) -> bool:
	return room_progress.get(room_name, 0) == 1  # Only visit if it's the correct order
