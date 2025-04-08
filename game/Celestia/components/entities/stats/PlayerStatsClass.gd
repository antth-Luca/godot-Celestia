extends BaseStats
class_name PlayerStats

signal leveled_up

const EXP_REQUIRED_NEXT_LV: int = 100
const MIN_LEVEL:int = 1
var level: int = 1

const MIN_XP:int = 0
var xp: int = 0


func _init():
	set_max_health(100)
	set_health(100)
	set_damage(6)
	set_min_move_speed(80.0)
	set_move_speed(80.0)

# Getters and Setters
func get_level() -> int:
	return level


func set_level(newLevel:int) -> void:
	if newLevel < MIN_LEVEL: return
	level = newLevel


func get_xp() -> int:
	return xp


func set_xp(newXp: int) -> void:
	if newXp < MIN_XP: return
	xp = newXp
	_check_and_do_level_up()

# Handlers
func _check_and_do_level_up() -> void:
	if xp < EXP_REQUIRED_NEXT_LV: return

	level += 1
	max_health += level
	health += level
	damage += level

	leveled_up.emit()
