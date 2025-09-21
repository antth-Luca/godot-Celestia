extends BaseProperty
class_name LuckProperty

var lk: float
const MIN_LK: int = 0


func _init(initial_value: float):
	set_luck(initial_value)

# Move Speed
func get_luck() -> float:
	return lk


func get_format_luck() -> String:
	return str(lk)


func set_luck(newLK: float) -> void:
	lk = max(newLK, MIN_LK)


func add_luck(addLK: float) -> void:
	set_luck(lk + addLK)


func sub_luck(subLK: float) -> void:
	set_luck(lk - subLK)
