extends Registry
class_name RarityRegistry

static var REGISTRY_TYPE: String = 'Rarities'


func register(id: ResourceLocation, entry: BaseRarity) -> void:
	super.register(id, entry)
