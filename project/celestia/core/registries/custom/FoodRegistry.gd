extends Registry
class_name FoodRegistry

static var REGISTRY_TYPE: String = 'Foods'


func register(id: ResourceLocation, entry: Callable) -> void:
	super.register(id, entry)
