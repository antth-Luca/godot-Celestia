extends Node
class_name BaseStats

# STATS
# Health
var max_hp: float
var hp: float
# Armor
var am: float = 0
# Resistence
var rs: float
# Dam. Reduction
var dam_r: float = 0
# Force
var fr: float
# Penetration
var pn: float = 0
# Def. Reduction
var def_r: float = 0
# Crit. Strike Chance
var crit_ch: float = 0
# Crit. Damage
var crit_dm: float = 2.0
# Life Steal
var ls: float = 0
# Range
var rg: float
# Use Speed
var us: float
# Move Speed
var ms: float
# Cooldown Redction
var cd_r: float = 0

# GETTERS AND SETTERS
# Health
func get_max_health() -> float:
	return max_hp

func get_format_max_health() -> int:
	return ceil(max_hp)

func set_max_health(newStat) -> void:
	if newStat <= 0: return
	max_hp = newStat

func get_health() -> float:
	return hp

func get_format_health() -> int:
	return ceil(hp)

func set_health(newStat) -> void:
	hp = clamp(newStat, 0, max_hp)

# Armor
func get_armor() -> float:
	return am

func get_format_armor() -> int:
	return ceil(am)

func set_armor(newStat) -> void:
	am = max(newStat, 0)

# Resistence
func get_resistence() -> float:
	return rs

func get_format_resistence() -> int:
	return ceil(rs)

func set_resistence(newStat) -> void:
	rs = max(newStat, 0)

# Dam. Reduction
func get_dam_reduction() -> float:
	return dam_r

func set_dam_reduction(newStat) -> void:
	dam_r = clamp(newStat, 0, 4)

# Force
func get_force() -> float:
	return fr

func get_format_force() -> int:
	return ceil(fr)

func set_force(newStat) -> void:
	fr = max(newStat, 0)

# Penetration
func get_penetration() -> float:
	return pn

func get_format_penetration() -> int:
	return ceil(pn)

func set_penetration(newStat) -> void:
	pn = max(newStat, 0)

# Def. Reduction
func get_def_reduction() -> float:
	return def_r

func set_def_reduction(newStat) -> void:
	def_r = clamp(newStat, 0, 5)

# Crit. Strike Chance
func get_crit_chance() -> float:
	return crit_ch

func get_format_crit_chance() -> int:
	return crit_ch * 100

func set_crit_chance(newStat) -> void:
	crit_ch = clamp(newStat, 0, 1)

# Crit. Damage
func get_crit_damage() -> float:
	return crit_dm

func get_format_crit_damage() -> int:
	return crit_dm * 100

func set_crit_damage(newStat) -> void:
	crit_dm = clamp(newStat, 1, 2.5)

# Life Steal
func get_life_steal() -> float:
	return ls

func get_format_life_steal() -> int:
	return ls * 100

func set_life_steal(newStat) -> void:
	ls = max(newStat, 0)

# Range
func get_range() -> float:
	return rg

func set_range(newStat) -> void:
	rg = max(newStat, 1)

# Use Speed
func get_use_speed() -> float:
	return us

func set_use_speed(newStat) -> void:
	us = clamp(newStat, 0.2, 3)

# Move Speed
func get_move_speed() -> float:
	return ms

func set_move_speed(newStat) -> void:
	ms = max(newStat, 0)

# Cooldown Redction
func get_cooldown_reduction() -> float:
	return cd_r

func get_format_cooldown_reduction() -> int:
	return cd_r * 100

func set_cooldown_reduction(newStat) -> void:
	cd_r = clamp(newStat, 0, 5)
