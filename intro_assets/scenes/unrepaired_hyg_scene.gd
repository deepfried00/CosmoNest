extends Node2D

@onready var typing_sound = $Voice
@onready var text_label = $CanvasLayer/Control/RichTextLabel
@onready var robodim = $CanvasLayer2/Control/Robodim/AnimatedSprite2D
@onready var arrow_image = $CanvasLayer2/Arrow




var dialogue_data = []
var dialogue_index = 0
var text_index = 0
var is_typing = false
var full_text = ""
var dialogue_finished = false

const FONT_PATH = "res://intro_assets/font/public-pixel-font/PublicPixel-rv0pA.ttf"

func _ready():
	dialogue_data = load("res://intro_assets/scenes/unrep_Hyg_DIALOGUE'.gd").new().get_dialogue()
	robodim.play()
	MusicManager.set_music_state(false)
	show_next_line()
	

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if dialogue_finished:
			return

		if is_typing:
			is_typing = false
			typing_sound.stop()
			text_label.visible_characters = full_text.length()
		else:
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
					dialogue_finished = true

func show_next_line():
	var entry = dialogue_data[dialogue_index]
	full_text = entry["texts"][text_index]

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
		if i % 2 == 0 and text[i] != " " and not typing_sound.playing:
			typing_sound.play()
		await get_tree().create_timer(0.04).timeout

	typing_sound.stop()
	is_typing = false
