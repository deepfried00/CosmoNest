extends Node2D

@onready var arrow_image = $Arrow
@onready var typing_sound = $Voice
@onready var text_label = $CanvasLayer/Control/RichTextLabel
@onready var robodim = $CanvasLayer2/Control/Robodim/AnimatedSprite2D

var dialogue_data = []
var dialogue_index = 0
var text_index = 0
var is_typing = false
var full_text = ""
var dialogue_finished = false  # <-- To track if text is all done

const FONT_PATH = "res://intro_assets/font/public-pixel-font/PublicPixel-rv0pA.ttf"

func _ready():
	dialogue_data = load("res://intro_assets/scenes/cockpit_dialogues.gd").new().get_dialogue()
	arrow_image.visible = false
	MusicManager.set_music_state(true)
	show_next_line()
	robodim.play()

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if dialogue_finished:  # Stop music when final click after dialogue
			return

		if is_typing:
			# Skip typing animation and show full text instantly
			is_typing = false
			typing_sound.stop()
			text_label.visible_characters = full_text.length()
		else:
			# Go to next line or end dialogue
			text_index += 1
			if text_index < dialogue_data[dialogue_index]["texts"].size():
				show_next_line()
			else:
				dialogue_index += 1
				text_index = 0
				if dialogue_index < dialogue_data.size():
					show_next_line()
				else:
					text_label.clear()
					arrow_image.visible = false
					dialogue_finished = true  # Dialogue complete
					# Wait for final click to stop BGM (handled above)

func show_next_line():
	var entry = dialogue_data[dialogue_index]
	full_text = entry["texts"][text_index]

	# Optional image
	arrow_image.visible = entry.has("image")

	# Apply font and black color
	var bbcode_prefix = ""
	if entry.has("font"):
		bbcode_prefix += "[font=%s]" % entry["font"].resource_path
	bbcode_prefix += "[color=black]"

	var bbcode_text = "%s%s[/color]" % [bbcode_prefix, full_text]
	if entry.has("font"):
		bbcode_text += "[/font]"

	text_label.bbcode_text = bbcode_text
	text_label.visible_characters = 0
	is_typing = true
	start_typing(full_text)

func start_typing(text: String) -> void:
	var char_count = text.length()
	typing_sound.play()

	for i in range(char_count):
		if not is_typing:
			break
		text_label.visible_characters = i + 1
		if i % 2 == 0 and text[i] != " ":
			if not typing_sound.playing:
				typing_sound.play()
		await get_tree().create_timer(0.04).timeout

	typing_sound.stop()
	is_typing = false
