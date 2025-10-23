extends Node2D

@onready var typing_sound = $Voice
@onready var text_label = $CanvasLayer/Control/RichTextLabel
@onready var robodim = $CanvasLayer2/Control/Robodim/AnimatedSprite2D

@onready var choice_container = $CanvasLayer/Control/VBoxContainer
@onready var choice_label = $CanvasLayer/Control/choices

# 🆕 Save button is an Area2D with TextureRect + CollisionShape2D
@onready var save_button = $CanvasLayer/Control/SaveButton
var scene_path_self := "res://intro_assets/scenes/engine/engine_scene.tscn"

var scene_changing: bool = false
var dialogue_data = []
var dialogue_index = 0
var text_index = 0
var is_typing = false
var full_text = ""
var dialogue_finished = false

const FONT_PATH = "res://intro_assets/font/public-pixel-font/PublicPixel-rv0pA.ttf"

func _ready():
	dialogue_data = load("res://intro_assets/scenes/engine/engine_DIALOGUE.gd").new().get_dialogue()
	robodim.play()
	MusicManager.set_music_state(true)
	if choice_container:
		choice_container.visible = false
	if choice_label:
		choice_label.visible = false

	save_button.visible = false  # hidden until end of dialogue

	# ✅ connect to input_event correctly
	if save_button.has_signal("input_event"):
		save_button.connect("input_event", Callable(self, "_on_save_button_input_event"))
	else:
		print("⚠ SaveButton has no input_event signal. Make sure it’s an Area2D!")

	show_next_line()


func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if dialogue_finished:
			return
		if scene_changing:
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
					var entry = dialogue_data[dialogue_index - 1]

					# 🆕 --- SHOW SAVE BUTTON BEFORE CHOICES ---
					if entry.has("choices"):
						print("🟢 Dialogue ended — showing save button BEFORE choices.")
						save_button.visible = true
						print("✅ SaveButton set to visible:", save_button.name)

						# Wait a bit before showing choices
						await get_tree().create_timer(0.5).timeout
						show_choices(entry["choices"])
					else:
						# No choices → standard behavior
						print("🟢 Dialogue finished — showing save button (no choices).")
						save_button.visible = true
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


func show_choices(choices):
	dialogue_finished = true
	choice_container.visible = true
	if choice_label:
		choice_label.visible = true

	for child in choice_container.get_children():
		child.queue_free()

	for choice in choices:
		var btn = Button.new()
		btn.text = choice["text"]
		btn.connect("pressed", Callable(self, "_on_choice_selected").bind(choice))
		choice_container.add_child(btn)


func _on_choice_selected(choice: Dictionary):
	save_button.visible = false  # 🆕 hide save when choice is picked
	choice_container.visible = false
	if choice_label:
		choice_label.visible = false
	dialogue_finished = false

	if choice.has("robodim"):
		full_text = choice["robodim"]
	else:
		full_text = "..."

	var bbcode_prefix = "[font=%s][color=black]" % FONT_PATH
	var bbcode_text = "%s%s[/color][/font]" % [bbcode_prefix, full_text]

	text_label.bbcode_text = bbcode_text
	text_label.visible_characters = 0
	is_typing = true
	start_typing(full_text)

	if choice.has("action"):
		match choice["action"]:
			"change_scene":
				scene_changing = true
				await get_tree().create_timer(5).timeout
				Transition.transition_to_scene(choice["target"])
			"advance_dialogue":
				await get_tree().create_timer(1.2).timeout
				dialogue_finished = true


# ✅ Proper function to handle Area2D SaveButton clicks
func _on_save_button_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		print("💾 Save button clicked!")

		var payload := {
			"room_states": RoomStateManager.room_states,
			"cutscene_played": RoomStateManager.cutscene_played,
			"room_progress": RoomStateManager.room_progress
		}

		SaveMain.save_checkpoint(scene_path_self, "engine_before_choices", payload)
		print("✅ Game saved BEFORE choices.")
		save_button.visible = false
