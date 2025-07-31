extends RefCounted
class_name Registry

var _entries: Dictionary = {}


func register(id: String, entry: Resource) -> void:
	if _entries.has(id):
		push_error("Duplicate registry entry: %s" % id)
	else:
		_entries[id] = entry


func get_entry(id: String) -> Resource:
	return _entries.get(id)


func has(id: String) -> bool:
	return _entries.has(id)


func all() -> Dictionary:
	return _entries.duplicate()
