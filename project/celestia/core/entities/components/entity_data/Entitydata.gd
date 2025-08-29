extends RefCounted
class_name EntityData

enum FACTION_MASK {
	PLAYER = 0b0001,
	BOSS = 0b0010,
	MONSTER = 0b0100,
	ANIMAL = 0b1000,
	STRUCT = 0b1001
}

var faction: FACTION_MASK
var team: String
var stats: PropertyManager
var is_invincible: bool
var is_alive: bool
