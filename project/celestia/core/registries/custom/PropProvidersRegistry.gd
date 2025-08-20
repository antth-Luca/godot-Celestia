extends Registry
class_name PropProviderRegistry

static var REGISTRY_TYPE: String = 'PropProviders'


func register(id: ResourceLocation, entry: BasePropertyProvider) -> void:
	super.register(id, entry)
