extends BaseProperty
class_name ArmorProperty

var am: float
const MIN_AM: int = 0


func _init(initial_value: float):
	set_armor(initial_value)

# Armor
func get_armor() -> float:
	return am


func get_format_armor() -> String:
	return str(int(am))


func set_armor(newAM: float) -> void:
	am = max(newAM, MIN_AM)


func add_armor(addAM: float) -> void:
	set_armor(am + addAM)


func sub_armor(subAM: float) -> void:
	set_armor(am - subAM)
