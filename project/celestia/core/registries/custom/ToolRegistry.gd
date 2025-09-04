extends Registry
class_name ToolRegistry

static var REGISTRY_TYPE: String = 'Tools'


func register(id: ResourceLocation, entry: Callable) -> void:
	super.register(id, entry)
