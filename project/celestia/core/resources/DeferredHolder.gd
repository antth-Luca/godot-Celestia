extends RefCounted
class_name DeferredHolder

var type: String
var location: ResourceLocation


func _init(_type_registry: String, _location: ResourceLocation) -> void:
	type = _type_registry
	location = _location


func get_registered():
	var obj = RegistryManager.registries.get(type)._registries.get(location).call()
	obj.set_id(location)
	return obj
