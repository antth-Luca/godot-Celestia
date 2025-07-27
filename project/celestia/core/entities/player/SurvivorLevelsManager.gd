extends Node
class_name SurvivorLevels

# STATS
# Survivor XP
var xp: int = 0
# Survivor Level
var level: int  = 1

# GETTERS AND SETTERS
func get_xp() -> int:
	return xp

func set_xp(newStat) -> void:
	xp = max(newStat, 0)

func add_xp(amountXP) -> void:
	xp += amountXP
	_check_and_do_level_up()

# HANDLERS
func _check_and_do_level_up() -> void:
	if xp < 100: return

	level += 1
	xp -= 100
	emit_signal("level_up")
