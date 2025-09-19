extends BaseProperty
class_name HungryProperty

signal max_hungry_changed(new_max_hungry: float)
signal hungry_changed(new_hungry: float)

var MAX_HUNGRY: float
var hungry: float
const MIN_HUNGRY: int = 0


func _init(initial_value: float):
	set_max_hungry(initial_value)
	set_hungry(initial_value)

# Stamina
func get_hungry() -> float:
	return hungry


func get_format_hungry() -> String:
	return str(int(hungry))


func set_hungry(newHUNGRY: float) -> void:
	hungry = clamp(newHUNGRY, MIN_HUNGRY, MAX_HUNGRY)
	emit_signal('hungry_changed', hungry)


func add_hungry(addStam: float) -> void:
	set_hungry(hungry + addStam)


func sub_hungry(subHP: float) -> void:
	set_hungry(hungry - subHP)

# Max Stamina
func get_max_hungry() -> float:
	return MAX_HUNGRY


func get_format_max_hungry() -> String:
	return str(int(MAX_HUNGRY))


func set_max_hungry(newMaxHP: float) -> void:
	MAX_HUNGRY = max(MIN_HUNGRY, newMaxHP)
	emit_signal('max_hungry_changed', MAX_HUNGRY)


func add_max_hungry(addMaxStam: float) -> void:
	set_max_hungry(MAX_HUNGRY + addMaxStam)


func sub_max_health(subMaxHP: float) -> void:
	set_max_hungry(MAX_HUNGRY - subMaxHP)
