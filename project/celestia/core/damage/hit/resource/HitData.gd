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

var attacker: LivingEntity
var primitive_type: PRIMITIVE_TYPE
var specialized_type: SPECIALIZED_TYPE
var tool: BaseItem

# GODOT
func _init(attacker_param: LivingEntity, primitive_type_param: PRIMITIVE_TYPE, specialized_type_param: SPECIALIZED_TYPE, tool_param: BaseItem = null) -> void:
	attacker = attacker_param
	primitive_type = primitive_type_param
	specialized_type = specialized_type_param
	tool = tool_param
