extends Area2D

func _ready():
	connect("input_event", Callable(self, "_on_screenshot_click"))

func _on_screenshot_click(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		print("📸 Taking screenshot...")
		_take_screenshot()

func _take_screenshot():
	# 1️⃣ Grab the current viewport image
	var img := get_viewport().get_texture().get_image()

	# 2️⃣ (Optional) Flip vertically — Godot’s viewport images are upside down by default
	
	# 3️⃣ Create a timestamped filename
	var time_str := Time.get_datetime_string_from_system().replace(":", "-")
	var path := "user://screenshot_" + time_str + ".png"

	# 4️⃣ Save the image
	var err := img.save_png(path)
	if err == OK:
		print("✅ Screenshot saved to:", path)
	else:
		push_warning("⚠️ Screenshot save failed: %s" % err)

	# 5️⃣ (Optional) show a quick flash or popup
	_flash_screen()
	# or play a sound effect if you have one

func _flash_screen():
	var flash = ColorRect.new()
	flash.color = Color(1, 1, 1, 0.7)
	flash.size = get_viewport_rect().size
	get_tree().get_root().add_child(flash)
	var tween = get_tree().create_tween()
	tween.tween_property(flash, "modulate:a", 0, 0.4)
	await tween.finished
	flash.queue_free()
