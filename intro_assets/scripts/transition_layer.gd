extends CanvasLayer

signal on_transition_finished

@onready var color_rect = $ColorRect
@onready var animation_player = $AnimationPlayer

var _next_scene_path = ""

func _ready():
	color_rect.visible = false
	animation_player.animation_finished.connect(_on_animation_finished)


func transition_to_scene(scene_path: String):
	_next_scene_path = scene_path
	color_rect.visible = true
	animation_player.play("fade_to_black")


func _on_animation_finished(anim_name):
	if anim_name == "fade_to_black":
		get_tree().change_scene_to_file(_next_scene_path)
		animation_player.play("fade_to_normal")
	elif anim_name == "fade_to_normal":
		color_rect.visible = false
