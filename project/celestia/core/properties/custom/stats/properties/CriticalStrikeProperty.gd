extends BaseProperty
class_name CriticalStrikeProperty

const MAX_CRIT_CH: int = 1
var crit_ch: float
const MIN_CRIT_CH: int = 0
const MAX_CRIT_DM: float = 2.5
var crit_dm: float = 2.0
const MIN_CRIT_DM: int = 1
var hit_counter: int = 0
var crit_strike_counter: int
var max_crit_strikes: int

# GODOT
func _init(initial_value: float):
	set_crit_chance(initial_value)

# GETTERS AND SETTERS
# Crit. Strike Chance
func get_crit_chance() -> float:
	return crit_ch


func get_format_crit_chance() -> String:
	return str(int(crit_ch * 100)) + '%'


func set_crit_chance(newCritCh: float) -> void:
	crit_ch = clamp(newCritCh, MIN_CRIT_CH, MAX_CRIT_CH)
	max_crit_strikes = ceil(crit_ch * 10)


func add_crit_chance(addCritCh: float) -> void:
	set_crit_chance(crit_ch + addCritCh)


func sub_crit_chance(subCritCh: float) -> void:
	set_crit_chance(crit_ch - subCritCh)

# Crit. Damage
func get_crit_damage() -> float:
	return crit_dm


func get_format_crit_damage() -> String:
	return str(crit_dm) + 'x'


func set_crit_damage(newCritDm: float) -> void:
	crit_dm = clamp(newCritDm, MIN_CRIT_DM, MAX_CRIT_DM)


func add_crit_damage(addCritDm: float) -> void:
	set_crit_damage(crit_dm + addCritDm)


func sub_crit_damage(subCritDm: float) -> void:
	set_crit_damage(crit_dm - subCritDm)

# HANDLERS
func compute_critical_strike() -> bool:
	if max_crit_strikes == 10: return true  # If there is a 100% chance of a critical strike
	hit_counter += 1
	if max_crit_strikes == 0: return false  # If there is a 0% chance of a critical strike
	var is_crit: bool = false
	if crit_strike_counter <= max_crit_strikes:  # If the critical hit counter has not yet reached its maximum
		# If they are the latest hits available and you haven't hit critical so far OR you've hit critical chance
		if 10 - hit_counter <= max_crit_strikes or randf_range(0, 1) <= get_crit_chance():
			is_crit = true
			crit_strike_counter += 1
	if hit_counter >= 10:
		hit_counter = 0
		crit_strike_counter = 0
	return is_crit
