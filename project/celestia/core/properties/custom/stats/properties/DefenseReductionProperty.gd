extends BaseProperty
class_name DefenseReductionProperty

const MAX_DEF_R: int = 4
var def_r: float
const MIN_DEF_R: int = 0

# Def. Reduction
func get_dam_reduction() -> float:
	return def_r


func set_dam_reduction(newDefenseReduction) -> void:
	def_r = clamp(newDefenseReduction, MIN_DEF_R, MAX_DEF_R)
