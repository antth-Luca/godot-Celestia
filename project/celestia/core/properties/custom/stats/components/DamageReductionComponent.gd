extends PropertyBaseComponent
class_name DamageReductionComponent

const MAX_DAM_R: int = 4
var dam_r: float
const MIN_DAM_R: int = 0

# Dam. Reduction
func get_dam_reduction() -> float:
	return dam_r


func set_dam_reduction(newDamageReduction) -> void:
	dam_r = clamp(newDamageReduction, MIN_DAM_R, MAX_DAM_R)
