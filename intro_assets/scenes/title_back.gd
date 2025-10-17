# title_back.gd
extends Node2D
@onready var back_button: Area2D = $back_button   # your Area2D with TextureRect + CollisionShape2D

func _ready():
	back_button.connect("input_event", Callable(self, "_on_back_button_input_event"))


func _on_back_button_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if Engine.has_meta("previous_scene"):
				var prev := str(Engine.get_meta("previous_scene"))
				print("🔙 Returning to:", prev)
				get_tree().change_scene_to_file(prev)
			else:
				print("⚠ No previous scene stored.")
