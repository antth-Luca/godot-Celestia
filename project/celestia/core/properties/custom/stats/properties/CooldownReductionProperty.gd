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


func get_format_cooldown_reduction() -> int:
	@warning_ignore("narrowing_conversion")
	return cd_r * 100


func set_cooldown_reduction(newCdR: float) -> void:
	cd_r = clamp(newCdR, MIN_CD_R, MAX_CD_R)
