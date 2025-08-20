extends BaseProperty
class_name DamageReductionProperty

const MAX_DAM_R: int = 4
var dam_r: float
const MIN_DAM_R: int = 0


func _init(initial_value: float):
	set_dam_reduction(initial_value)

# Dam. Reduction
func get_dam_reduction() -> float:
	return dam_r


func get_format_damage_reduction() -> String:
	return str(int(dam_r)) + '%'


func set_dam_reduction(newDamageReduction) -> void:
	dam_r = clamp(newDamageReduction, MIN_DAM_R, MAX_DAM_R)


func add_dam_reduction(addDamageReduction: float) -> void:
	set_dam_reduction(dam_r + addDamageReduction)


func sub_dam_reduction(subDamageReduction: float) -> void:
	set_dam_reduction(dam_r - subDamageReduction)
