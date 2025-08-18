extends Registry
class_name RarityRegistry


func _ready() -> void:
	REGISTRY_TYPE = 'Rarities'


func register(id: ResourceLocation, entry: BaseRarity) -> void:
	super.register(id, entry)
