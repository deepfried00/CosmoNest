extends Resource

func get_dialogue():
	return [
		{
			"speaker": "Robodim",
			"font": preload("res://intro_assets/font/public-pixel-font/PublicPixel-rv0pA.ttf"),
			"texts": [
				""" This is good to go! """,
				"""You have a separate place to store equipment and medical kits""",
				"""as well as some food!""",
					"""You see, the CEO of ******* """,
					""" decided that the furniture should be made of soft leather """ ,
					"""and look like wood to give a homey feel to the workers. """ , 
					"""He is very generous!"""
			]
		},
		{
			"speaker": "Robodim",
			"image": preload("res://intro_assets/scenes/arrow.png"),
			"font": preload("res://intro_assets/font/public-pixel-font/PublicPixel-rv0pA.ttf"),
			"texts": [
			"""Now let's head to the Galley!"""
					]			
		}
	]
