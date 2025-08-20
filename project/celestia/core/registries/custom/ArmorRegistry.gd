extends Registry
class_name ArmorRegistry

static var REGISTRY_TYPE: String = 'Armors'


func register(id: ResourceLocation, entry: Callable) -> void:
	super.register(id, entry)
