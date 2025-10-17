extends Node2D

@onready var play_button = $new  # Area2D
@onready var continue_button = $continue  # Area2D
@onready var quit_button = $quit  # Area2D
@onready var music_button = $music  # Area2D
@onready var music_icon = $music/TextureRect  # TextureRect inside the music button
@onready var bgm_player = $BGM  # Optional: for main menu background music

func _ready():
	# Connect button input events
	play_button.connect("input_event", Callable(self, "_on_new_input_event"))
	continue_button.connect("input_event", Callable(self, "_on_continue_input_event"))
	quit_button.connect("input_event", Callable(self, "_on_quit_input_event"))
	music_button.connect("input_event", Callable(self, "_on_music_input_event"))

	# Check if there's a saved checkpoint
	if SaveMain.has_checkpoint():
		continue_button.visible = true
	else:
		continue_button.visible = true

	# Optional menu background music
	if bgm_player:
		if MusicManager.music_on:
			bgm_player.play()
		else:
			bgm_player.stop()

	# Update icon based on current music state
	_update_music_icon()

# 🎮 NEW GAME
func _on_new_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		print("🎮 New Game started.")
		get_tree().change_scene_to_file("res://intro_assets/scenes/intro.tscn")

# 💾 CONTINUE GAME
func _on_continue_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		print("⏩ Continuing from last save...")

		var checkpoint_data = SaveMain.load_checkpoint()
		if typeof(checkpoint_data) != TYPE_DICTIONARY:
			print("⚠ Invalid save file type.")
			continue_button.visible = true
			return

		if not checkpoint_data.has("scene"):
			print("⚠ Save file missing 'scene' key.")
			continue_button.visible = true
			return

		var scene_path = str(checkpoint_data["scene"])
		if not ResourceLoader.exists(scene_path):
			print("⚠ Saved scene path not found:", scene_path)
			continue_button.visible = true
			return

		var payload = checkpoint_data.get("payload", {})
		if typeof(payload) == TYPE_DICTIONARY:
			RoomStateManager.room_states = payload.get("room_states", {})
			RoomStateManager.cutscene_played = payload.get("cutscene_played", {})
			RoomStateManager.room_progress = payload.get("room_progress", {})

		print("✅ Loading saved scene:", scene_path)
		get_tree().change_scene_to_file(scene_path)

# 🔈 MUSIC TOGGLE
func _on_music_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		# Toggle global music ON/OFF
		MusicManager.toggle_music()
		_update_music_icon()

		# Sync local AudioStreamPlayer (bgm_player) with global state
		if bgm_player and bgm_player.stream:
			# Enable loop depending on stream type
			if bgm_player.stream is AudioStreamOggVorbis:
				(bgm_player.stream as AudioStreamOggVorbis).loop = true
			elif bgm_player.stream is AudioStreamMP3:
				(bgm_player.stream as AudioStreamMP3).loop = true
			elif bgm_player.stream is AudioStreamWAV:
				(bgm_player.stream as AudioStreamWAV).loop_mode = AudioStreamWAV.LOOP_FORWARD
			else:
				# Fallback: re-connect the finished signal to loop manually
				if not bgm_player.is_connected("finished", Callable(self, "_loop_bgm")):
					bgm_player.connect("finished", Callable(self, "_loop_bgm"))


# ❌ QUIT GAME
func _on_quit_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		print("👋 Quitting game.")
		get_tree().quit()

# 🎵 Update the music button’s icon
func _update_music_icon():
	if music_button and music_button.has_node("TextureRect"):
		var tex_rect = music_button.get_node("TextureRect")
		tex_rect.texture = MusicManager.music_on_icon if MusicManager.music_on else MusicManager.music_off_icon

func _loop_bgm() -> void:
	if bgm_player:
		bgm_player.play()
