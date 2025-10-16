extends Resource

func get_dialogue():
	return [
		{
			"speaker": "Robodim",
			"font": preload("res://intro_assets/font/public-pixel-font/PublicPixel-rv0pA.ttf"),
			"texts": [
				"""This is supposed to be used for entertainment and fitness both."""
			]
		},
			{
			"yes": preload("res://intro_assets/scenes/Yes_-removebg-preview.png"),
			"font": preload("res://intro_assets/font/public-pixel-font/PublicPixel-rv0pA.ttf"),
			"texts": [
				"""Well, let's decorate this place!"""
			]
		}
	]
