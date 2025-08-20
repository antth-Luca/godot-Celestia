extends BaseProperty
class_name ResistanceProperty

var rs: float
const MIN_RS: int = 0


func _init(initial_value: float):
	set_resistance(initial_value)

# Resistence
func get_resistance() -> float:
	return rs


func get_format_resistance() -> int:
	return ceil(rs)


func set_resistance(newRS: float) -> void:
	rs = max(newRS, MIN_RS)
