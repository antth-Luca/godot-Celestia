extends Registry
class_name LootBoxRegistry

static var REGISTRY_TYPE: String = 'LootBoxes'


func register(id: ResourceLocation, entry: Callable) -> void:
	super.register(id, entry)
