extends Resource

func get_dialogue():
	return [
		{
			"speaker": "Robodim",
			"image": preload("res://intro_assets/scenes/arrow.png"),
			"font": preload("res://intro_assets/font/public-pixel-font/PublicPixel-rv0pA.ttf"),
			"texts": [
				"""Well...let's go to the next room!""",
				"""I heard that a human came in before me """, 
				"""and cleaned some of the places beforehand. """,
				"""Wouldn't say they were the best at it though..."""

			]
		}
	]
