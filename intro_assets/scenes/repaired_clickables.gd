extends Area2D

@onready var bio = $bio  # This is the clickable CollisionShape2D
@onready var power = $power
@onready var co2 = $co2
@onready var togalley = $togalley
@onready var tocockpit = $tocockpit
@onready var bgm_player = $Gamesound

@onready var algae = $algae  # This is the TextureRect popup
@onready var gen = $gen
@onready var co22 = $co22

func _ready():
	connect("input_event", Callable(self, "_on_click"))

	# Start with all popups hidden
	algae.visible = false
	gen.visible = false
	co22.visible = false
	bgm_player.play() 

func _on_click(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var clicked_shape = get_child(shape_idx)

		match clicked_shape.name:
			"bio":
				algae.visible = true
			"power":
				gen.visible = true
			"co2":
				co22.visible = true
			"togalley":
				Transition.transition_to_scene("res://intro_assets/scenes/theungalley_scene1.tscn")
				bgm_player.stop() 
			"tocockpit":
				print("was clicked")
				bgm_player.stop() 
				Transition.transition_to_scene("res://intro_assets/scenes/cockpitmain.tscn") 
