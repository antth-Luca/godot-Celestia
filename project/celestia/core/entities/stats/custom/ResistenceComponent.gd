extends BaseStatComponent
class_name ResistenceComponent

var rs: float
const MIN_RS: int = 0

# Resistence
func get_resistence() -> float:
	return rs


func get_format_resistence() -> int:
	return ceil(rs)


func set_resistence(newRS: float) -> void:
	rs = max(newRS, MIN_RS)
