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


func get_format_mana() -> String:
	return str(int(mp))


func set_mana(newMP: float) -> void:
	mp = clamp(newMP, MIN_MP, MAX_MP)


func add_mana(addMP: float) -> void:
	set_mana(mp + addMP)


func sub_mana(subMP: float) -> void:
	set_mana(mp - subMP)

# Max HP
func get_max_mana() -> float:
	return MAX_MP


func get_format_max_mana() -> String:
	return str(int(MAX_MP))


func set_max_mana(newMaxMP: float) -> void:
	MAX_MP = max(MIN_MP, newMaxMP)


func add_max_mana(addMaxMP: float) -> void:
	set_max_mana(MAX_MP + addMaxMP)


func sub_max_mana(subMaxMP: float) -> void:
	set_max_mana(MAX_MP - subMaxMP)
