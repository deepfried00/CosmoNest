extends Node2D

@onready var typing_sound = $Voice
@onready var text_label = $CanvasLayer/Control/RichTextLabel
@onready var robodim = $CanvasLayer2/Control/Robodim/AnimatedSprite2D
@onready var yes_area = $CanvasLayer/Area2D

var dialogue_data = []
var dialogue_index = 0
var text_index = 0
var is_typing = false
var full_text = ""
var dialogue_finished = false


func _ready():
	dialogue_data = load("res://intro_assets/scenes/mass/massDialogue.gd").new().get_dialogue()
	robodim.play()
	yes_area.connect("input_event", Callable(self, "_on_yes_area_input_event"))
	yes_area.visible = false
	show_next_line()

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if yes_area.visible:
			return

		if dialogue_finished:
			return

		if is_typing:
			is_typing = false
			typing_sound.stop() # Added to stop sound when skipping text
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
					yes_area.hide()
					dialogue_finished = true

func show_next_line():
	var entry = dialogue_data[dialogue_index]
	full_text = entry["texts"][text_index]

	if entry.has("yes"):
		yes_area.get_node("TextureRect").texture = entry["yes"]
		yes_area.show()
	else:
		yes_area.hide()

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

func _on_yes_area_input_event(viewport: Node, event: InputEvent, shape_idx: int):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		print("Yes button clicked, transitioning to next scene.")
		typing_sound.stop() # Stop sound on button press
		Transition.transition_to_scene("res://intro_assets/scenes/mass/base_mass.tscn")
		get_viewport().set_input_as_handled()
