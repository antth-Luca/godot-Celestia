extends Node
class_name Registry

var _entries: Dictionary = {}


func register(id: String, entry) -> void:
	if _entries.has(id):
		push_warning('Duplicate registry entry: %s' % id)
		return

	if entry.get_id() == '':
		entry.set_id(id)
	elif entry.get_id() != id:
		push_warning('Entry "%s" has a different internal ID "%s" than the registered ID "%s".' % [entry.resource_path, entry.get_id(), id])
	_entries[id] = entry


func has(id: String) -> bool:
	return _entries.has(id)


func get_entry(id: String):
	return _entries.get(id)


func get_all_entries() -> Dictionary:
	return _entries.duplicate()
