extends Registry
class_name ItemRegistry

static var REGISTRY_TYPE: String = 'Items'


func register(id: ResourceLocation, entry: Callable) -> void:
	super.register(id, entry)
