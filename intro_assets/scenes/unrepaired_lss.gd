extends Node2D

@onready var text_label = $CanvasLayer/Area2D/infoBox/CanvasLayer2/Control/RichTextLabel
@onready var info_box = $CanvasLayer/Area2D/infoBox

const FONT_PATH = "res://intro_assets/font/public-pixel-font/PublicPixel-rv0pA.ttf"

func _ready():
	info_box.visible = false  # Start hidden

func show_info_popup_text():
	if not info_box:
		print("❌ info_box not found!")
		return

	info_box.visible = true  # Show popup

	var dialogue_data = load("res://intro_assets/scenes/lssunrepairedInfo.gd").new().get_dialogue()
	var entry = dialogue_data[0]

	var full_text = ""
	for line in entry["texts"]:
		full_text += line + "\n\n"

	var bbcode_text = ""
	if entry.has("font"):
		bbcode_text += "[font=%s]" % entry["font"].resource_path
	bbcode_text += "[color=black]%s[/color]" % full_text
	if entry.has("font"):
		bbcode_text += "[/font]"

	text_label.bbcode_text = bbcode_text
