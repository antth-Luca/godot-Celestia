extends RefCounted
class_name Registry

var _registries: Dictionary = {}


func register(location: ResourceLocation, entry) -> void:
	var str_location = location.get_string()
	if _registries.has(str_location):
		push_warning('Duplicate registry entry: %s' % str_location)
		return

	var entry_id: String = entry.get_id().get_string()
	if entry_id == ResourceLocation.EMPTY.get_string():
		entry.set_id(location)
	elif entry_id != str_location:
		push_warning(
			'Registry: Entry "%s" has a different internal ID than the registered ID "%s".' % [
				entry_id, str_location
			]
		)
	_registries[str_location] = entry


func get_entry(str_location: String):
	return _registries.get(str_location)
