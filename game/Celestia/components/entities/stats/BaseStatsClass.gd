extends Node
class_name BaseStats

const MIN_HEALTH: int = 0
var max_health: int = 1
var health: int = 1

const MIN_DAMAGE = 0
var damage: int = 0

const MIN_DEFENSE: int = 0
var defense: int = 0

const MIN_CRITICAL_CHANCE: int = 0
var critical_chance: int = 0
const MAX_CRITICAL_CHANCE: int = 100

const MIN_CRITICAL_DAMAGE: int = 200
var critical_damage: int = 200
const MAX_CRITICAL_DAMAGE: int = 250

const MIN_LIFE_STEAL: int = 0
var life_steal: int = 0

const MIN_PENETRATION: int = 0
var penetration: int = 0
const MAX_PENETRATION: int = 100

const MIN_USE_RANGE: int = 1
var use_range: int = 1

const MIN_MOVE_SPEED: float = 0.0
var move_speed: float = 0.0

const MIN_ATTACK_SPEED: float = 0.0
var attack_speed: float = 0.0

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
	if newDamage < MIN_DAMAGE:
		damage = MIN_DAMAGE
	damage = newDamage


func get_defense() -> int:
	return defense


func set_defense(newDefense:int) -> void:
	if newDefense < MIN_DEFENSE:
		defense = MIN_DEFENSE
	defense = newDefense


func get_critical_chance() -> int:
	return critical_chance


func set_critical_chance(newCritChance:int) -> void:
	critical_chance = clamp(newCritChance, MIN_CRITICAL_CHANCE, MAX_CRITICAL_CHANCE)


func get_critical_damage() -> int:
	return critical_damage


func set_critical_damage(newCritDamage:int) -> void:
	critical_damage = clamp(newCritDamage, MIN_CRITICAL_DAMAGE, MAX_CRITICAL_DAMAGE)


func get_life_steal() -> int:
	return life_steal


func set_life_steal(newLifeSteal:int) -> void:
	if newLifeSteal < MIN_LIFE_STEAL:
		life_steal = MIN_LIFE_STEAL
	life_steal = newLifeSteal


func get_penetration() -> int:
	return penetration


func set_penetration(newPen) -> void:
	penetration = clamp(newPen, MIN_PENETRATION, MAX_PENETRATION)


func get_range() -> int:
	return use_range


func set_range(newRange:int) -> void:
	if newRange < MIN_USE_RANGE:
		use_range = MIN_USE_RANGE
	use_range = newRange


func get_move_speed() -> float:
	return move_speed


func set_move_speed(newSpeed:float) -> void:
	if newSpeed < MIN_MOVE_SPEED: return
	move_speed = newSpeed


func get_attack_speed() -> float:
	return attack_speed


func set_attack_speed(newSpeed:float) -> void:
	if newSpeed < MIN_ATTACK_SPEED: return
	attack_speed = newSpeed
