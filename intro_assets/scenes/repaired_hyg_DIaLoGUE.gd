extends Resource

func get_dialogue():
	return [
		{
			"speaker": "Robodim",
			"font": preload("res://intro_assets/font/public-pixel-font/PublicPixel-rv0pA.ttf"),
			"texts": [
				"""Voila! It's as good as new! """,
				"""There's even a sink to wash their hands from!""",
				""""Now only if the recycle bin was in a """,
				"""more obvious place here...""",
				"""alas it's attached to the wall""",
				"""Now lets go to the Crew Quarter. """,
				]
				},
				{
			"speaker": "Robodim",
			"image": preload("res://intro_assets/scenes/arrow.png"),
			"font": preload("res://intro_assets/font/public-pixel-font/PublicPixel-rv0pA.ttf"),
			"texts": [
			"""The door is on the right. See?"""
					]
				}
	]
