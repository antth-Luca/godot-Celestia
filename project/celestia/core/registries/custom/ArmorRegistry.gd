extends Registry
class_name ArmorRegistry

static var REGISTRY_TYPE: String = 'Armors'


func register(id: ResourceLocation, entry: BaseArmor) -> void:
	super.register(id, entry)
