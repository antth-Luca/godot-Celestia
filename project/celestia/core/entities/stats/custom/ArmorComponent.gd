extends BaseStatComponent
class_name ArmorComponent

var am: float
const MIN_AM: int = 0

# Armor
func get_armor() -> float:
	return am


func get_format_armor() -> int:
	return ceil(am)


func set_armor(newAM: float) -> void:
	am = max(newAM, MIN_AM)
