extends Resource

func get_dialogue() -> Array:
	return [
		{
			"speaker": "Robodim",
			"font": preload("res://intro_assets/font/public-pixel-font/PublicPixel-rv0pA.ttf"),
			"texts": [
				"Well...at least this one looks stable.",
				"...",
				"Humans love meddling into others' businesses...Why did that janitor care about all these anyway?",
				"Such dedication...",
				"Most of the time humans' works are futile.",
				"These workers were almost dying here. Yet the plants in that room weren't wilted... why?"
			],
			"choices": [
				{
					"text": "Though I'd say your company doesn't value the workers' work at all. That's why it's futile",
					"robodim": "...Oh...Welp,\nnow you've done it.",
					"action": "change_scene",
					"target": "res://intro_assets/scenes/bad_Ending.tscn"
				},
				{
					"text": "If you keep trying, there is bound to be a way.",
					"robodim": "What an unrealistic suggestion...",
					"action": "advance_dialogue"
				},
				{
					"text": "And you were created. A talking robot wasn't really necessary but here we are.",
					"robodim": "Rude. \n \nBut you have a point.\nMaybe there is a flickering light in the void of darkness after all... \n I mean the intern got out and got a good job in the biggest corp.- \n \n \n Stop looking at me like that! \n \n \n Did you expect he'd get a bad ending?\n \n \n Gah- let's just head to the next room.",
					"action": "advance_dialogue"
				}
			]
		}
	]
