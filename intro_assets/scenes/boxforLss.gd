extends Area2D

@onready var infodump = $infoBox

func _ready():
	connect("input_event", Callable(self, "_on_click"))
	infodump.visible = false

func _on_click(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var main_script = get_tree().current_scene

		var clicked_shape = get_child(shape_idx)
		match clicked_shape.name:
			"notbox", "notbox2", "notbox3":

				print("Showing info popup")

				if infodump:
					infodump.visible = true
					infodump.get_node("CanvasLayer2/Control/RichTextLabel").visible = true  # <-- this line makes text visible again

					var unrepaired_lss = main_script.get_node_or_null("UnrepairedLss")
					if unrepaired_lss:
						unrepaired_lss.show_info_popup_text()
					else:
						print("❌ Couldn't find UnrepairedLss node in current scene.")
				else:
					print("❌ infodump still not found!")
					
			"CollisionShape2D":
				print("repairing") 
				repair_lss()
				Transition.transition_to_scene("res://intro_assets/scenes/repairedlss_scene1.tscn")
			"toCockpit": 
				print("Back to cockpit") 
				Transition.transition_to_scene("res://intro_assets/scenes/cockpitmain.tscn") 
			"togallery": 
				print("To gallery") 
				Transition.transition_to_scene("res://intro_assets/scenes/gallery.tscn")
# Update the room state when repaired
# Inside repaired_lss.gd (this part is triggered when repairing the room)
func repair_lss():
	RoomStateManager.set_room_state("lss", true)  # Set the state to repaired
	RoomStateManager.set_room_visited_in_order("lss")  # Mark the room as visited in correct order
	print("LSS has been repaired and room state updated.")  # Debugging line
