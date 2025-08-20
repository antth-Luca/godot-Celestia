extends BaseProperty
class_name ManaProperty

var MAX_MP: float
var mp: float
const MIN_MP: int = 0


func _init(initial_value: float):
	set_max_mana(initial_value)
	set_mana(initial_value)

# HP
func get_mana() -> float:
	return mp


func get_format_mana() -> int:
	return ceil(mp)


func set_mana(newMP: float) -> void:
	mp = clamp(newMP, MIN_MP, MAX_MP)

# Max HP
func get_max_mana() -> float:
	return MAX_MP


func get_format_max_mana() -> int:
	return ceil(MAX_MP)


func set_max_mana(newMaxMP: float) -> void:
	MAX_MP = max(MIN_MP, newMaxMP)
