extends Node

@onready var windy = $Area2D
@onready var climate = $weather

# Replace these with your actual links 👇
const CLIMATE := "https://open-meteo.com/en/docs?hourly=temperature_2m,rain,relative_humidity_2m,weather_code,pressure_msl,wind_speed_120m,apparent_temperature,dew_point_2m,precipitation&current=rain,temperature_2m,relative_humidity_2m,pressure_msl,snowfall,wind_gusts_10m,wind_direction_10m,surface_pressure&daily=rain_sum"
const WINDY := "https://www.windy.com/-Weather-radar-radar?radar,52.382,4.899,5"

func _ready():
	# Connect their click events
	windy.connect("input_event", Callable(self, "_on_Area2D_clicked"))
	climate.connect("input_event", Callable(self, "_on_weather_clicked"))


func _on_Area2D_clicked(viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		print("🌐 Opening windy page...")
		OS.shell_open(WINDY)


func _on_weather_clicked(viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		print("🐦 Opening climate page...")
		OS.shell_open(CLIMATE)
