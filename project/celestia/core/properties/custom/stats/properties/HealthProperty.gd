extends BaseProperty
class_name HealthProperty

var MAX_HP: float
var hp: float
const MIN_HP: int = 0


func _init(initial_value: float):
	MAX_HP = initial_value
	hp = initial_value

# HP
func get_health() -> float:
	return hp


func get_format_health() -> int:
	return ceil(hp)


func set_health(newHP: float) -> void:
	hp = clamp(newHP, MIN_HP, MAX_HP)

# Max HP
func get_max_health() -> float:
	return MAX_HP


func get_format_max_health() -> int:
	return ceil(MAX_HP)


func set_max_health(newMaxHP: float) -> void:
	MAX_HP = max(0, newMaxHP)
