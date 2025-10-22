extends Node2D

@onready var text_box: RichTextLabel = $CanvasLayer/RichTextLabel
@onready var bgm: AudioStreamPlayer = $Bad
@onready var typing_sound: AudioStreamPlayer = $TypingSound

var typing_speed := 0.04
var is_typing := false
var text_done := false
var full_text := ""

const BAD_ENDING_TEXT := """
Uh oh! You are sued! — for neglecting your work a bit too hard that caused all the astronauts in 
[i]*the name has been censored due to copyright issues*[/i] to rage quit! 
They say that you left the ship unrepaired and almost unlivable with extremely bland decorations, 
causing severe mental distress. Your mental state isn't any better either, 
as you have begun to see the press workers as minty shadowy entities merging as one to interview you. 
But that is the least of your concern now.

[b][color=red]BAD ENDING...[/color][/b]
"""

func _ready():
	full_text = BAD_ENDING_TEXT
	text_box.bbcode_enabled = true
	text_box.scroll_active = true
	text_box.clear()

	if bgm:
		bgm.stream_paused = not MusicManager.music_on
		if MusicManager.music_on:
			bgm.play()
		else:
			bgm.stop()

	await start_typing(full_text)


func start_typing(text: String) -> void:
	is_typing = true
	var current := ""

	for i in text.length():
		if not is_typing:
			break
		current += text[i]
		text_box.bbcode_text = "[font=res://intro_assets/font/public-pixel-font/PublicPixel-rv0pA.ttf]" + current + "[/font]"
		if text[i] != " " and i % 2 == 0 and MusicManager.music_on:
			if not typing_sound.playing:
				typing_sound.play()
		await get_tree().create_timer(typing_speed).timeout

	is_typing = false
	text_done = true
	typing_sound.stop()


func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if is_typing:
			is_typing = false
			text_box.bbcode_text = "[font=res://intro_assets/font/public-pixel-font/PublicPixel-rv0pA.ttf]" + full_text + "[/font]"
			typing_sound.stop()
