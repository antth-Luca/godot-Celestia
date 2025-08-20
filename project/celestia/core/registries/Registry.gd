extends RefCounted
class_name Registry

var _registries: Dictionary[ResourceLocation, Callable] = {}


func register(location: ResourceLocation, entry: Callable) -> void:
	if _registries.has(location):
		push_warning('Registry: Duplicate registry entry: %s' % location.get_string())
		return
	_registries[location] = entry
