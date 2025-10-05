# TextBox.gd
extends CanvasLayer

@onready var label = $Control/text

var typing_speed := 0.04
var _typing_task = null

func show_text(new_text: String, speed := typing_speed):
	label.bbcode_enabled = true
	label.clear()
	label.visible_characters = 0
	label.bbcode_text = new_text
	if _typing_task != null:
		_typing_task = null  # Optional: cancel old coroutine if needed
	_typing_task = await typing_animation(new_text, speed)

func typing_animation(text: String, speed):
	label.visible_characters = 0
	var char_count = text.length()
	for i in range(char_count):
		label.visible_characters = i + 1
		await get_tree().create_timer(speed).timeout
