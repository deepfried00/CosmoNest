extends Resource

func get_dialogue():
	return [
		{
			"speaker": "Robodim",
			"font": preload("res://intro_assets/font/public-pixel-font/PublicPixel-rv0pA.ttf"),
			"texts": [
				"""there is a note on the steel door!""",
				"""Such dedication...Such dedication...why do humans care about uncertainity so much?
				Well, I guess caring about it now gave you ways to save lives from floods or...simply enjoy the beauty together.
				I hope you have a good ending too, my friend. It was good talking and working with you. Even though you haven't replied to a single thing I have been saying.""",
				"<True ending>
				click on the bottom door to exit"
			]
		}
	]
