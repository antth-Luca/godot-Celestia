extends Registry
class_name MaterialRegistry

static var REGISTRY_TYPE: String = 'Materials'


func register(id: ResourceLocation, entry: Callable) -> void:
	super.register(id, entry)
