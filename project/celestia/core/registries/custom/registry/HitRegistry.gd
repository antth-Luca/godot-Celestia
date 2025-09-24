extends Registry
class_name HitRegistry

static var REGISTRY_TYPE: String = 'Hits'


func register(id: ResourceLocation, entry: Callable) -> void:
	super.register(id, entry)
