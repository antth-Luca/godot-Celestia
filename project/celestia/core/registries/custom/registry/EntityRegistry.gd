extends Registry
class_name EntityRegistry

static var REGISTRY_TYPE: String = 'Entities'


func register(id: ResourceLocation, entry: Callable) -> void:
	super.register(id, entry)
