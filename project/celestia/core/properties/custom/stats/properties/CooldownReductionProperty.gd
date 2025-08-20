extends BaseProperty
class_name CooldownReductionProperty

const MAX_CD_R: int = 5
var cd_r: float
const MIN_CD_R: int = 0


func _init(initial_value: float):
	set_cooldown_reduction(initial_value)

# Cooldown Redction
func get_cooldown_reduction() -> float:
	return cd_r


func get_format_cooldown_reduction() -> String:
	return str(int(cd_r * 100)) + '%'


func set_cooldown_reduction(newCdR: float) -> void:
	cd_r = clamp(newCdR, MIN_CD_R, MAX_CD_R)


func add_cooldown_reduction(addCdR: float) -> void:
	set_cooldown_reduction(cd_r + addCdR)


func sub_cooldown_reduction(subCdR: float) -> void:
	set_cooldown_reduction(cd_r - subCdR)
