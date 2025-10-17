extends CanvasLayer

@onready var menu_button: Area2D = get_node_or_null("menu_button")

# Scenes where the HUD should NOT be visible
var excluded_scenes := [
	"res://intro_assets/scenes/intro.tscn",
	"res://intro_assets/scenes/ending.tscn",
	"res://intro_assets/scenes/bad_Ending.tscn",
	"res://intro_assets/scenes/title_back.tscn",
	"res://intro_assets/scenes/title_Screen.tscn"
]

func _ready():
	await get_tree().process_frame
	if not menu_button:
		push_warning("⚠ menu_button not found in PersistentHUD!")
		return

	# CanvasLayer already draws on top, just ensure it's high priority
	layer = 100  # draw order priority among CanvasLayers
	menu_button.z_index = 9999

	menu_button.connect("input_event", Callable(self, "_on_menu_button_input_event"))
	print("✅ Persistent HUD ready and menu_button connected.")

	_update_visibility()

func _process(_delta):
	_update_visibility()

func _update_visibility():
	var current := get_tree().current_scene
	if not current:
		return

	var current_path := current.scene_file_path
	if current_path == "":
		return

	var should_hide := excluded_scenes.has(current_path)
	menu_button.visible = not should_hide

func _on_menu_button_input_event(_vp: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var current_scene := get_tree().current_scene
		if current_scene:
			Engine.set_meta("previous_scene", current_scene.scene_file_path)
			print("📜 Menu clicked from:", current_scene.scene_file_path)
		get_tree().change_scene_to_file("res://intro_assets/scenes/title_back.tscn")
