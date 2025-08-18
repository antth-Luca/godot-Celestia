extends Registry
class_name MaterialRegistry


func _init():
	super._init('Materials')


func register(id: ResourceLocation, entry: BaseMaterial) -> void:
	super.register(id, entry)
