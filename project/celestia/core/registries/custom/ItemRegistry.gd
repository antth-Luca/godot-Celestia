extends Registry
class_name ItemRegistry


func _init():
	super._init('Items')


func register(id: ResourceLocation, entry: BaseItem) -> void:
	super.register(id, entry)
