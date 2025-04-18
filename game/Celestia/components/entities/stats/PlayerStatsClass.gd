extends BaseStats
class_name PlayerStats

signal leveled_up

const MIN_XP:int = 0
var xp: int = 0

const EXP_REQUIRED_NEXT_LV: int = 100
const MIN_LEVEL:int = 1
var level: int = 1

const MIN_MANA: int = 0
var max_mana: int = 50
var mana: int = 50

const MIN_COOLDOWN: int = 0
var cooldown: int = 0
const MAX_COOLDOWN: int = 50


func _init():
	set_max_health(100)
	set_health(100)
	set_damage(6)
	set_move_speed(80.0)
	set_attack_speed(1.0)

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


func get_max_mana() -> int:
	return max_mana


func set_max_mana(newMax) -> void:
	if newMax <= MIN_MANA: return
	max_mana = newMax


func get_mana() -> int:
	return mana


func set_mana(newMana) -> void:
	mana = clamp(newMana, MIN_MANA, max_mana)


func get_cooldown() -> int:
	return cooldown


func set_cooldown(newCooldown) -> void:
	cooldown = clamp(newCooldown, MIN_COOLDOWN, MAX_COOLDOWN)

# Handlers
func _check_and_do_level_up() -> void:
	if xp < EXP_REQUIRED_NEXT_LV: return

	level += 1
	max_health += level
	health += level
	damage += level

	leveled_up.emit()
