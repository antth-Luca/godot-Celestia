extends BaseProperty
class_name SurvivorLevelProperty

const XP_REQUIRED: int = 100
var xp: int = 0
var level: int


func _init(initial_value: int):
	level = initial_value if initial_value > 0 else 1

# Xp
func get_xp() -> int:
	return xp


func get_format_xp() -> String:
	return str(xp)


func set_xp(newXP: int) -> void:
	xp = max(newXP, 0)


func add_xp(addXP: int) -> void:
	if not addXP > 0: return
	xp += addXP
	_check_and_do_level_up()

# HANDLERS
func _check_and_do_level_up() -> void:
	if xp < XP_REQUIRED: return
	level += 1
	xp -= XP_REQUIRED
	EventBus.client_player.emit_signal('level_up')
