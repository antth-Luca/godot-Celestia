extends BaseProperty
class_name RangeProperty

var rg: float
const MIN_RG: int = 1


func _init(initial_value: float):
	set_range(initial_value)

# Range
func get_range() -> float:
	return rg


func get_format_range() -> String:
	return str(rg)


func set_range(newRG: float) -> void:
	rg = max(newRG, MIN_RG)


func add_range(addRG: float) -> void:
	set_range(rg + addRG)


func sub_range(subRG: float) -> void:
	set_range(rg - subRG)
