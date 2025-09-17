extends Node
class_name TimeManager

const real_ingame_factor: float = 60

var day_night_cycle_gradient: GradientTexture1D
var natural_light: CanvasModulate
var day_counter: int
var time_counter: float

# GODOT
func _init(initial_hour: float, natural_light_param: CanvasModulate) -> void:
	day_night_cycle_gradient = load('res://assets/celestia/particles/daynightcycle-gradient-texture.tres')
	natural_light = natural_light_param
	time_counter = initial_hour * real_ingame_factor


func update(delta: float) -> void:
	time_counter += delta
	_check_time_cycle()
	var normalized_time = time_counter / 1440.0  # Define range (0 -> 1)
	var color_time_value = (sin(normalized_time * TAU - PI / 2.0) + 1.0) / 2.0  # Full curve per day + alignment at noon
	natural_light.color = day_night_cycle_gradient.gradient.sample(color_time_value)

# GETTERS AND SETTERS
func get_hours() -> int:
	return int(time_counter / 60) % 24


func get_minutes() -> int:
	return int(time_counter) % 60

# HANDLERS
func _check_time_cycle() -> void:
	if not time_counter < 1440:
		day_counter += 1
		time_counter = 0
