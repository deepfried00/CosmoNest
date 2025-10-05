# cockpit_dialogue.gd
extends Resource

func get_dialogue():
	return [
		{
			"speaker": "Robodim",
			"font": preload("res://intro_assets/font/public-pixel-font/PublicPixel-rv0pA.ttf"),
			"texts": [
				""" Hi, I'm Robodim. 

I will help you set this place up.""", 

""" Don't worry, the furnishing won't go flying away.""",

""" They will be attached to this spaceship real hard.""",

				"""Ohh, the cockpit is alright. Let's head to the next room then!"""
			]
		},
		{
			"speaker": "Robodim",
			"image": preload("res://intro_assets/scenes/arrow.png"),
			"font": preload("res://intro_assets/font/public-pixel-font/PublicPixel-rv0pA.ttf"),
			"texts": [
				"""Click on the steel doors to move between rooms.""" ,

"""Let's click the one on the top to head to """,

"""Life Support System'"""
			]
		},
	]
