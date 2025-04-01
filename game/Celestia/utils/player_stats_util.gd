extends Node

signal leveled_up

const EXP_REQUIRED_NEXT_LV: int = 100
var level: int = 1
var exp: int = 0
var health: int = 100
var max_health: int = 100
var damage: int = 6
var move_speed: float = 80.0


func get_player_stats():
	return {
		"health": health,
		"max_health": max_health,
		"damage": damage,
		"move_speed": move_speed
	}


func set_exp(newExp: int):
	exp = newExp
	_check_and_do_level_up()


func _check_and_do_level_up():
	if exp < EXP_REQUIRED_NEXT_LV: return

	level += 1
	max_health += level
	health += level
	damage += level
	
	leveled_up.emit()
