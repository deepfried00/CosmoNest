# slide_data.gd
extends Node

func get_slides() -> Array:
	return [
		{
			"image": preload("res://intro_assets/scenes/intro1.jpeg"),
			"texts": [
				"""It is year 2050. Technology is progressing rapidly.

The art of construction is everywhere.

People dine and do research in space from all over the world.""",

				"""If you have enough money, you can even dine in space

while staring into the abyss...""",

				"""See those little silver dots?

Those are space stations far away from the land of Earth.

Most are built from one of the world's biggest corporations —

*the name has been censored due to copyright guidelines*."""
			]
		},

		{
			"image": preload("res://intro_assets/scenes/intro2.jpg"),
			"texts": [
				"""On one unlucky day, a space-worker leaked secret files

about the company's mistreatment of workers.""",

				"""Pressure. No privacy. No hygiene.

A dull, decaying environment.

This led to widespread mental health breakdowns."""
			]
		},
		{
			"image": preload("res://intro_assets/scenes/intro3.jpg"),
			"texts": [
				"""The reports sparked a massive outrage among civilians,
				
				 leading to protests against the company's CEO. """,
				
				"""Due to the CEO's frivolously generous thinking, 
				
				he immediately responded and tasked specialists with 
				
				improving workplace condition.""",
			]
		},
				{
			"image": preload("res://intro_assets/scenes/intro4 (1).jpg"),
			"texts": [
				
				"""Tasks are assigned to all the workers, including you! """,
				
				 """You are tasked with managing one of the space stations'
				 
				environment while enjoying the dark beauty of space...
				
				to bring color into your abode..""",
			]
		}
	]
