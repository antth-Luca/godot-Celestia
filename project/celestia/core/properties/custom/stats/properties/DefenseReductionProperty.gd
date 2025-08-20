extends BaseProperty
class_name DefenseReductionProperty

const MAX_DEF_R: int = 4
var def_r: float
const MIN_DEF_R: int = 0


func _init(initial_value: float):
	set_def_reduction(initial_value)

# Def. Reduction
func get_def_reduction() -> float:
	return def_r


func get_format_def_reduction() -> int:
	return ceil(def_r)


func set_def_reduction(newDefenseReduction) -> void:
	def_r = clamp(newDefenseReduction, MIN_DEF_R, MAX_DEF_R)
