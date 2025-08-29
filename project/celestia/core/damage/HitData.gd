extends Resource
class_name HitData

enum PRIMITIVE_TYPE {
	PHYSIC,
	MAGIC,
	TRUE
}

enum SPECIALIZED_TYPE {
	PIERCE,
	EXPLOSION,
	LIGHT,
	ELETRIC
}

var attacker: EntityData
var primitive_type: PRIMITIVE_TYPE
var specialized_type: SPECIALIZED_TYPE
var is_crit: bool
