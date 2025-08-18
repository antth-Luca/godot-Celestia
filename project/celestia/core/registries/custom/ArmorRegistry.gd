extends Registry
class_name ArmorRegistry


func _init():
	super._init('Armors')


func register(id: ResourceLocation, entry: BaseArmor) -> void:
	super.register(id, entry)
