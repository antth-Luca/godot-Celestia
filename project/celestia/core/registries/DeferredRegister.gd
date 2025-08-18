extends RefCounted
class_name DeferredRegister

var mod_id: String
var registry: Registry
var _entries: Dictionary = {}


func _init(_mod_id: String, _registry: Registry):
	mod_id = _mod_id
	registry = _registry


static func create(_mod_id: String, type: String):
	return DeferredRegister.new(
		_mod_id,
		RegistryManager.registries[type]
	)


func add_entry(path: String, factory: Callable) -> DeferredHolder:
	var location = ResourceLocation.new(mod_id, path)
	if _entries.has(location):
		push_error("Duplicate ID: " + location.get_string())
		return null

	var entry = factory.call()
	_entries[location] = entry
	return DeferredHolder.new(registry.REGISTRY_TYPE, location)


func register() -> void:
	for location in _entries:
		registry.register(location, _entries[location])
