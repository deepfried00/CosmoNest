extends Node2D

@onready var text_box: RichTextLabel = $CanvasLayer/RichTextLabel
@onready var bgm: AudioStreamPlayer = $Gamesound
@onready var typing_sound: AudioStreamPlayer = $TypingSound

var typing_speed := 0.04
var is_typing := false
var text_done := false
var full_text := ""

const GOOD_ENDING_TEXT := """
Congratulations! You don't have your job anymore! By that means you have left your previous job. 
You are alive, well and attending a party with your friends for getting a new job at your dream company. 
You even met a new friend there, who happened to be an intern in the previous company you worked for. 
All is well that ends well...and now you know that the overtimes you worked for didn't go in vain.

[b][color=green]GOOD ENDING! (True Ending)[/color][/b]
"""

func _ready():
	full_text = GOOD_ENDING_TEXT
	text_box.bbcode_enabled = true
	text_box.scroll_active = true
	text_box.clear()

	# 🎵 Respect global music setting
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
