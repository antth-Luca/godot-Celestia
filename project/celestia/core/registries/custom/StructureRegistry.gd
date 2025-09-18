extends Registry
class_name StructureRegistry

static var REGISTRY_TYPE: String = 'Structures'


func register(id: ResourceLocation, entry: Callable) -> void:
	super.register(id, entry)
