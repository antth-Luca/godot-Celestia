extends Resource
class_name HitData

enum PRIMITIVE_TYPE {
	PHYSIC,
	MAGIC,
	TRUE
}

enum SPECIALIZED_TYPE {
	NONE,
	PIERCE,
	EXPLOSION,
	LIGHT,
	ELETRIC
}

var attacker: EntityData
var damage_factor: float
var primitive_type: PRIMITIVE_TYPE
var specialized_type: SPECIALIZED_TYPE
var is_crit: bool

# GODOT
func _init(attacker_param: EntityData, damage_factor_param: float, primitive_type_param: PRIMITIVE_TYPE, specialized_type_param: SPECIALIZED_TYPE) -> void:
	attacker = attacker_param
	damage_factor = damage_factor_param
	primitive_type = primitive_type_param
	specialized_type = specialized_type_param
	is_crit = attacker.stats.get_property(InitPropProviders.CRITICAL_STRIKE).compute_critical_strike()
