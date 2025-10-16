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

enum SOURCE {
	HIT,
	SPELL,
	EFFECT
}

var attacker: LivingEntity
var primitive_type: PRIMITIVE_TYPE
var specialized_type: SPECIALIZED_TYPE
var source: SOURCE
var tool: BaseItem
var effects_dict: Dictionary[DeferredHolder, float]

# GODOT
func _init(attacker_param: LivingEntity, primitive_type_param: PRIMITIVE_TYPE, specialized_type_param: SPECIALIZED_TYPE, source_param: SOURCE, tool_param: BaseItem = null, effects_to_apply: Dictionary[DeferredHolder, float] = {}) -> void:
	attacker = attacker_param
	primitive_type = primitive_type_param
	specialized_type = specialized_type_param
	source = source_param
	tool = tool_param
	effects_dict = effects_to_apply
