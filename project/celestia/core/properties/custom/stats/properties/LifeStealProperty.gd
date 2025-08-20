extends BaseProperty
class_name LifeStealProperty

var ls: float
const MIN_LS: int = 0


func _init(initial_value: float):
	set_life_steal(initial_value)

# Life Steal
func get_life_steal() -> float:
	return ls


func get_format_life_steal() -> String:
	return str(int(ls * 100)) + '%'


func set_life_steal(newLS: float) -> void:
	ls = max(newLS, MIN_LS)


func add_life_steal(addLS: float) -> void:
	set_life_steal(ls + addLS)


func sub_life_steal(subLS: float) -> void:
	set_life_steal(ls - subLS)
