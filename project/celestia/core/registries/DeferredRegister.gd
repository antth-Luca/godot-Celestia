extends RefCounted
class_name DeferredRegister

var mod_id: String
var registry: Registry
var holders := {}


func _init(_mod_id: String, _registry: Registry):
	mod_id = _mod_id
	registry = _registry


func register(path: String, factory: Callable):
	var location = ResourceLocation.new(mod_id, path)
	if registry.has(location):
		push_error("Duplicate ID: " + location.get_string())
		return null

	var entry = factory.call()
	registry.register(location, entry)
	holders[location.get_string()] = entry
	return entry
