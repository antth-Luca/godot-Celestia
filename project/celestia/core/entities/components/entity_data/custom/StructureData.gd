extends EntityData
class_name StructureData

var compatible_tools: Array[String]
var compatible_materials: Array[String]

# GODOT
func _init(compatible_tools_param: Array[BaseItem], compatible_materials_param: Array[BaseMaterial], stats_param: PropertyManager, is_dead_param: bool = false) -> void:
	# Parent
	faction = FACTION_MASK.STRUCTURE
	stats = stats_param
	is_dead = is_dead_param
	# Child
	for tool_class in compatible_tools_param:
		compatible_tools.append(tool_class.to_string())
	for material_class in compatible_materials_param:
		compatible_materials.append(material_class.to_string())
