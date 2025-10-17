extends Node2D

@onready var play_button = $new               # Area2D
@onready var continue_button = $continue      # Area2D
@onready var quit_button = $quit              # Area2D
@onready var music_button = $music            # Area2D
@onready var music_icon = $music/TextureRect  # TextureRect inside the music button
@onready var bgm_player = $BGM                # Optional menu background music

func _ready():
	# ✅ Connect input_event signals
	play_button.connect("input_event", Callable(self, "_on_new_input_event"))
	continue_button.connect("input_event", Callable(self, "_on_continue_input_event"))
	quit_button.connect("input_event", Callable(self, "_on_quit_input_event"))
	music_button.connect("input_event", Callable(self, "_on_music_input_event"))

	# ✅ Show continue only if save exists
	continue_button.visible = true

	# ✅ Respect global music setting
	_update_music_icon()
	_apply_global_music_state()

	# ✅ Optional menu background music — only plays when music is ON
	if bgm_player:
		bgm_player.stream_paused = not MusicManager.music_on
		if MusicManager.music_on:
			bgm_player.play()
		else:
			bgm_player.stop()


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
		MusicManager.toggle_music(music_icon)  # toggle global sound
		_update_music_icon()
		_apply_global_music_state()


# ❌ QUIT GAME
func _on_quit_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		print("👋 Quitting game.")
		get_tree().quit()


# 🧠 Update the icon texture to match current state
func _update_music_icon():
	if music_icon:
		music_icon.texture = MusicManager.music_on_icon if MusicManager.music_on else MusicManager.music_off_icon


# 🌍 Apply the current global sound state to all audio
func _apply_global_music_state():
	# Mute/unmute everything in the Master bus (typing, bgm, etc.)
	var master_bus = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_mute(master_bus, not MusicManager.music_on)

	# Sync title BGM
	if bgm_player:
		if MusicManager.music_on:
			bgm_player.stream_paused = false
			bgm_player.play()
		else:
			bgm_player.stop()
