extends RefCounted
class_name DeferredHolder

var type: String
var location: ResourceLocation


func _init(_type_registry: String, _location: ResourceLocation) -> void:
	type = _type_registry
	location = _location


func get_registered():
	return RegistryManager.registries.get(type).get(location.get_string())
