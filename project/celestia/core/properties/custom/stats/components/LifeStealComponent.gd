extends PropertyBaseComponent
class_name LifeStealComponent

var ls: float
const MIN_LS: int = 0

# Life Steal
func get_life_steal() -> float:
	return ls


func get_format_life_steal() -> int:
	@warning_ignore("narrowing_conversion")
	return ls * 100


func set_life_steal(newLS: float) -> void:
	ls = max(newLS, MIN_LS)
