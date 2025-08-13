extends Node
class_name Registry

var _entries: Dictionary = {}


func register(location: ResourceLocation, entry) -> void:
	var full_id = location.get_string()
	if _entries.has(full_id):
		push_warning('Duplicate registry entry: %s' % full_id)
		return

	if entry.get_id().get_string() == ResourceLocation.get_empty_location().get_string():
		entry.set_id(location)
	elif entry.get_id().get_string() != full_id:
		push_warning(
			'Registry: Entry "%s" has a different internal ID than the registered ID "%s".' % [
				entry.get_id().get_string(), full_id
			]
		)
	_entries[full_id] = entry


func has(location: ResourceLocation) -> bool:
	return _entries.has(location.get_string())


func get_entry(location: ResourceLocation):
	return _entries.get(location.get_string())


func get_all_entries() -> Dictionary:
	return _entries.duplicate()
