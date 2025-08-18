extends Node
class_name Registry

static var REGISTRY_TYPE: String = ''
var EMPTY_LOCATION: String = ResourceLocation.get_empty_location().get_string()

var _registries: Dictionary = {}


func _init(type: String) -> void:
	REGISTRY_TYPE = type


func register(location: ResourceLocation, entry) -> void:
	var str_location = location.get_string()
	if _registries.has(str_location):
		push_warning('Duplicate registry entry: %s' % str_location)
		return

	var entry_id: String = entry.get_id().get_string()
	if entry_id == EMPTY_LOCATION:
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
