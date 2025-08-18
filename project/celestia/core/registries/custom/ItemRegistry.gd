extends Registry
class_name ItemRegistry


func _ready() -> void:
	REGISTRY_TYPE = 'Items'


func register(id: ResourceLocation, entry: BaseItem) -> void:
	super.register(id, entry)
