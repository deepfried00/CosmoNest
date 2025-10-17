extends Node
# Autoload this as "MusicManager" (Project Settings → Autoload) for global access.

@onready var player: AudioStreamPlayer = AudioStreamPlayer.new()

var music_on: bool = true  # global music state

# (Optional) icons if you want to update a UI TextureRect somewhere
var music_on_icon: Texture2D  = preload("res://intro_assets/scenes/Settings.png")
var music_off_icon: Texture2D = preload("res://intro_assets/scenes/Sound off button.png")

# Default BGM path (change if you want)
const DEFAULT_BGM_PATH := "res://intro_assets/sound/gamesound.mp3"

func _ready() -> void:
	# Ensure the player exists in the tree
	if not player.get_parent():
		add_child(player)
		# If you have a "Music" bus in your Audio Bus Layout, route to it
		if AudioServer.get_bus_index("Music") != -1:
			player.bus = "Music"

	player.volume_db = -6.0
	player.autoplay = false

	# Connect finished (for manual loop fallback)
	if not player.is_connected("finished", Callable(self, "_on_player_finished")):
		player.connect("finished", Callable(self, "_on_player_finished"))

	# Load & play default music
	play_bgm(DEFAULT_BGM_PATH)


func play_bgm(path: String) -> void:
	# Load the stream and set it on the player
	var stream: AudioStream = load(path)
	if stream == null:
		push_warning("MusicManager: Could not load stream: %s" % path)
		return

	player.stream = stream
	_setup_stream_loop(stream)

	if music_on:
		player.play()
	else:
		player.stop()


func toggle_music(texture_rect: TextureRect = null) -> void:
	music_on = not music_on
	if music_on:
		player.play()
		print("🎵 Music ON")
	else:
		player.stop()
		print("🔇 Music OFF")

	# Optionally update a UI icon if you pass a TextureRect
	if texture_rect:
		texture_rect.texture = music_on_icon if music_on else music_off_icon


func set_music_state(state: bool, texture_rect: TextureRect = null) -> void:
	music_on = state
	if music_on:
		player.play()
	else:
		player.stop()

	if texture_rect:
		texture_rect.texture = music_on_icon if music_on else music_off_icon


func _on_player_finished() -> void:
	# Fallback loop if the stream type doesn't support built-in looping
	if music_on and player.stream != null:
		player.play()


func _setup_stream_loop(stream: AudioStream) -> void:
	# In Godot 4, loop is a property on certain stream types, not on the player.
	# Try to enable loop if the type supports it; otherwise rely on finished→play fallback.
	if stream is AudioStreamOggVorbis:
		(stream as AudioStreamOggVorbis).loop = true
	elif stream is AudioStreamMP3:
		(stream as AudioStreamMP3).loop = true
	elif stream is AudioStreamWAV:
		(stream as AudioStreamWAV).loop_mode = AudioStreamWAV.LOOP_FORWARD
	else:
		# Unknown type—finished signal handler will re-play to simulate looping.
		pass
