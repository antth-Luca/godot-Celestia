extends RefCounted
class_name DeferredHolder

var type: String
var location: ResourceLocation


func _init(type_registry_param: String, location_param: ResourceLocation) -> void:
	type = type_registry_param
	location = location_param


func get_registered():
	var obj = RegistryManager.registries.get(type)._registries.get(location).call()
	obj.id = location
	return obj


func get_listed():
	return RegistryManager.registries.get(type)._registries.get(location).call()
