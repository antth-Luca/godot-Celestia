extends RefCounted
class_name EntityData

enum FACTION_MASK {
	PLAYER = 0b0001,
	BOSS = 0b0010,
	MONSTER = 0b0100,
	ANIMAL = 0b1000,
	STRUCT = 0b1001
}

var faction: FACTION_MASK = FACTION_MASK.STRUCT
var team: String
var stats: PropertyManager
var is_invincible: bool = false
var is_dead: bool

# GODOT
func _init(faction_param: FACTION_MASK, stats_param: PropertyManager, is_dead_param: bool = false):
	faction = faction_param
	stats = stats_param
	is_dead = is_dead_param
