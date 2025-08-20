extends BaseProperty
class_name PenetrationProperty

var pn: float
const MIN_PN: int = 0


func _init(initial_value: float):
	pn = initial_value

# Penetration
func get_penetration() -> float:
	return pn


func get_format_penetration() -> int:
	return ceil(pn)


func set_penetration(newPN: float) -> void:
	pn = max(newPN, MIN_PN)
