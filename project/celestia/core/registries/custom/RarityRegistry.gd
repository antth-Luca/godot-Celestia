extends Registry
class_name RarityRegistry


func _init():
	super._init('Rarities')


func register(id: ResourceLocation, entry: BaseRarity) -> void:
	super.register(id, entry)
