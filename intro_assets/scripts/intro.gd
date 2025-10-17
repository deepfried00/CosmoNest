extends Node2D

@onready var text_box = $CanvasLayer/introtext/RichTextLabel
@onready var image_node = $introslides # or TextureRect
@onready var bgm_player = $introtheme
@onready var typing_sound = $typingSound
@onready var logo = $CanvasLayer2/logoforIntro
var logo_faded_in = false


var slides = []

var slide_index = 0
var text_index = 0

var typing_speed := 0.04  # seconds per character
var is_typing := false
var full_text := ""
var typing_coroutine = null

func _ready():
	slides = load("res://intro_assets/intro_texts.gd").new().get_slides()
	MusicManager.set_music_state(true)
	logo.modulate.a = 0.0  # start fully transparent
	logo.visible = true    # visible but transparent
	update_slide()
	if MusicManager.music_on:
		bgm_player.play()
	else:
		bgm_player.stop()

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if is_typing:
			# Finish typing instantly
			typing_sound.stop() 
			finish_typing()
		else:
			# Move to next text or slide
			text_index += 1
			if text_index < slides[slide_index]["texts"].size():
				update_text()
			else:
				typing_sound.stop() 
				slide_index += 1
				text_index = 0
				if slide_index < slides.size():
					update_slide()
				else:
					fade_in_logo()
					if logo_faded_in:
						bgm_player.stop()
						Transition.transition_to_scene("res://intro_assets/scenes/cockpitscene1.tscn")




func _on_transition_complete(target_scene_path: String):
	get_tree().change_scene_to_file(target_scene_path)


func update_slide():
	image_node.texture = slides[slide_index]["image"]
	update_text()
	
func fade_in_logo(): 
	if logo_faded_in:
		return  
	logo_faded_in = true

	logo.visible = true
	logo.modulate.a = 0.0
	var tween = get_tree().create_tween()
	tween.tween_property(logo, "modulate:a", 1.0, 1.5)


func update_text():
	full_text = slides[slide_index]["texts"][text_index]
	text_box.clear()
	is_typing = true
	await start_typing(full_text)

func start_typing(text: String) -> void:
	var current = ""
	for i in text.length():
		# Stop typing if the user has clicked to skip
		if not is_typing:
			return
		
		current += text[i]
		text_box.bbcode_text = "[font=res://intro_assets/font/public-pixel-font/PublicPixel-rv0pA.ttf]" + current + "[/font]"

		if text[i] != " " and i % 2 == 0:
			if not typing_sound.playing:
				typing_sound.play()

		await get_tree().create_timer(typing_speed).timeout

	is_typing = false
	typing_sound.stop() 
	if slide_index == slides.size() - 1 and text_index == slides[slide_index]["texts"].size() - 1:
		fade_in_logo()
func finish_typing():
	is_typing = false
	text_box.bbcode_text = "[font=res://intro_assets/font/public-pixel-font/PublicPixel-rv0pA.ttf]" + full_text + "[/font]"
