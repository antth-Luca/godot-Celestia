extends Registry
class_name ArmorRegistry


func _ready() -> void:
	REGISTRY_TYPE = 'Armors'


func register(id: ResourceLocation, entry: BaseArmor) -> void:
	super.register(id, entry)
