extends BaseProperty
class_name CriticalStrikeProperty

const MAX_CRIT_CH: int = 1
var crit_ch: float
const MIN_CRIT_CH: int = 0
const MAX_CRIT_DM: float = 2.5
var crit_dm: float = 2.0
const MIN_CRIT_DM: int = 1


func _init(initial_value: float):
	set_crit_chance(initial_value)

# Crit. Strike Chance
func get_crit_chance() -> float:
	return crit_ch


func get_format_crit_chance() -> int:
	@warning_ignore("narrowing_conversion")
	return crit_ch * 100


func set_crit_chance(newCritCh: float) -> void:
	crit_ch = clamp(newCritCh, MIN_CRIT_CH, MAX_CRIT_CH)

# Crit. Damage
func get_crit_damage() -> float:
	return crit_dm


func set_crit_damage(newCritDm: float) -> void:
	crit_dm = clamp(newCritDm, MIN_CRIT_DM, MAX_CRIT_DM)
