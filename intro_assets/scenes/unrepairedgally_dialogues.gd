extends Resource

func get_dialogue():
	return [
		{
			"speaker": "Robodim",
			"font": preload("res://intro_assets/font/public-pixel-font/PublicPixel-rv0pA.ttf"),
			"texts": [
				""" This is the Galley! It's what you would call a kitchen. """,
				"""Astronauts can't literally cook things,""",  
				"""so they heat compressed 
				food in here using those ovens-"""
			]
		},
		{
			"speaker": "Robodim",
			"font": preload("res://intro_assets/font/public-pixel-font/PublicPixel-rv0pA.ttf"),
			"texts": [
				"""[shake] !!! 
				[/shake]""" 
				,
				"""Oh my...this one needs repairing too! """ ,
				"""And a bit of cleaning. 
				Those workers were clearly very enraged!"""
			]
		}
	]
