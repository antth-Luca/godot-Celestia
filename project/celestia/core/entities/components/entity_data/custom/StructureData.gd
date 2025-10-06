extends EntityData
class_name StructureData

var compatible_tools: Array[String]
var compatible_materials: Array[BaseMaterial]

# GODOT
func _init(compatible_tools_param: Array[String], compatible_materials_param: Array[BaseMaterial], stats_param: PropertyManager, is_dead_param: bool = false) -> void:
	# Parent
	faction = FACTION_MASK.STRUCTURE
	stats = stats_param
	is_dead = is_dead_param
	# Child
	compatible_tools = compatible_tools_param
	compatible_materials = compatible_materials_param
