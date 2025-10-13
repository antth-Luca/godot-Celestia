extends RefCounted
class_name EntityData

enum FACTION_MASK {
	PLAYER = 0b0001,
	BOSS = 0b0010,
	MONSTER = 0b0100,
	ANIMAL = 0b1000,
	STRUCTURE = 0b1001
}

var faction: FACTION_MASK = FACTION_MASK.ANIMAL
var team: String
var stats: PropertyManager
var is_invincible: bool = false
var is_stunned: bool = false
var is_dead: bool = false
var active_effects: Array[BaseEffect]

# GODOT
func _init(faction_param: FACTION_MASK, stats_param: PropertyManager):
	faction = faction_param
	stats = stats_param
