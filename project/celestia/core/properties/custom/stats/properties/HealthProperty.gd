extends BaseProperty
class_name HealthProperty

var MAX_HP: float
var hp: float
const MIN_HP: int = 0


func _init(initial_value: float):
	set_max_health(initial_value)
	set_health(initial_value)

# HP
func get_health() -> float:
	return hp


func get_format_health() -> String:
	return str(int(hp))


func set_health(newHP: float) -> void:
	hp = clamp(newHP, MIN_HP, MAX_HP)

# Max HP
func get_max_health() -> float:
	return MAX_HP


func get_format_max_health() -> String:
	return str(int(MAX_HP))


func set_max_health(newMaxHP: float) -> void:
	MAX_HP = max(MIN_HP, newMaxHP)
