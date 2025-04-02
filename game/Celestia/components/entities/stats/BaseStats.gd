extends Node
class_name BaseStats

const MIN_HEALTH: int = 0
var max_health: int = 1
var health: int = 1

const MIN_DAMAGE = 0
var damage: int = 0

var min_move_speed: float = 0.0
var move_speed: float = 0.0

# Getters and Settes
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


func get_min_move_speed() -> float:
	return min_move_speed


func set_min_move_speed(newMinSpeed:float) -> void:
	min_move_speed = newMinSpeed


func get_move_speed() -> float:
	return move_speed


func set_move_speed(newSpeed:float) -> void:
	if newSpeed < min_move_speed: return
	move_speed = newSpeed
