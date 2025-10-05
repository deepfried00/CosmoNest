extends Node2D
@onready var video_player = $CanvasLayer2/VideoStreamPlayer


func _ready():
	video_player.play()
