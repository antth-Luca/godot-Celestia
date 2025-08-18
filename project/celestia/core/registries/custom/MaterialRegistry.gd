extends Registry
class_name MaterialRegistry


func _ready() -> void:
	REGISTRY_TYPE = 'Materials'


func register(id: ResourceLocation, entry: BaseMaterial) -> void:
	super.register(id, entry)
