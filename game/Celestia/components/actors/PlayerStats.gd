extends Node
class_name PlayerStats

signal leveled_up

const EXP_REQUIRED_NEXT_LV: int = 100
const MIN_LEVEL:int = 1
var level: int = 1

const MIN_XP:int = 0
var xp: int = 0

const MIN_HEALTH: int = 0
var max_health: int = 100
var health: int = 100

const MIN_DAMAGE = 0
var damage: int = 6

const MIN_MOVE_SPEED: float = 80.0
var move_speed: float = 80.0

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


func get_max_health() -> int:
	return max_health


func set_max_health(newMax) -> void:
	if newMax <= MIN_HEALTH: return
	max_health = newMax


func get_health() -> int:
	return health


func set_health(newHealth) -> void:
	health = clamp(newHealth, MIN_HEALTH, max_health)


func get_damage() -> int:
	return damage


func set_damage(newDamage:int) -> void:
	if newDamage < MIN_DAMAGE: return
	damage = newDamage


func get_move_speed() -> float:
	return move_speed


func set_move_speed(newSpeed:float) -> void:
	if move_speed < MIN_MOVE_SPEED: return
	move_speed = newSpeed

# Handlers
func _check_and_do_level_up() -> void:
	if xp < EXP_REQUIRED_NEXT_LV: return

	level += 1
	max_health += level
	health += level
	damage += level

	leveled_up.emit()
