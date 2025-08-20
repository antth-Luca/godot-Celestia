extends BaseProperty
class_name PenetrationProperty

var pn: float
const MIN_PN: int = 0


func _init(initial_value: float):
	set_penetration(initial_value)

# Penetration
func get_penetration() -> float:
	return pn


func get_format_penetration() -> String:
	return str(int(pn))


func set_penetration(newPN: float) -> void:
	pn = max(newPN, MIN_PN)


func add_penetration(addPN: float) -> void:
	set_penetration(pn + addPN)


func sub_penetration(subPN: float) -> void:
	set_penetration(pn - subPN)
