extends Node

const TimeOfDay = {
	EARLY_MORNING = [0, 420],
	MORNING = [420, 780],
	AFTERNOON = [781, 1140],
	NIGHT = [1141, 1439]
}

# --------------
#  I = ingame
#  R = real
# --------------
const total_Ihours_per_Iday: int = 24
const total_Rseconds_per_Ihour: int = 60
const total_Rseconds_per_Iday: float = 1440.0  # total_Ihours_per_Iday * total_Rseconds_per_Ihour

@onready var day_night_cycle_gradient: GradientTexture1D = load('res://assets/celestia/particles/daynightcycle-gradient-texture.tres')

var is_freeze: bool = true
var natural_light: CanvasModulate
var day_counter: int
var time_counter: float
var time_curve_value: float

# GODOT
func _process(delta: float) -> void:
	if is_freeze: return
	time_counter += delta
	_check_time_cycle()
	var normalized_time = int(time_counter) / total_Rseconds_per_Iday  # Define range (0 -> 1)
	time_curve_value = (sin(normalized_time * TAU - PI / 2.0) + 1.0) / 2.0  # Full curve per day + alignment at noon
	natural_light.color = day_night_cycle_gradient.gradient.sample(time_curve_value)

# MAIN
func initialize(initial_hour: float, natural_light_param: CanvasModulate) -> void:
	natural_light = natural_light_param
	time_counter = initial_hour * total_Ihours_per_Iday
	is_freeze = false


func is_time_to_go_to_bed() -> bool:
	if (
		time_counter < TimeOfDay.EARLY_MORNING.back()
	) or (
		time_counter > TimeOfDay.NIGHT.front()
	): return true
	return false

# GETTERS AND SETTERS
func set_morning() -> void:
	time_counter = TimeOfDay.EARLY_MORNING.back()

func get_hours() -> int:
	return int(time_counter / total_Rseconds_per_Ihour) % total_Ihours_per_Iday


func get_minutes() -> int:
	return int(time_counter) % total_Rseconds_per_Ihour


# HANDLERS
func _check_time_cycle() -> void:
	if not time_counter < total_Rseconds_per_Iday:
		day_counter += 1
		time_counter = 0
