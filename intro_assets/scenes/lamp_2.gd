extends Node2D

@onready var anim_sprite = $AnimatedSprite2D  # Adjust if your node name is different

func _ready():
	anim_sprite.play("lamp2")  # Replace "idle" with the name of your animation
