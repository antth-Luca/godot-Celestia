extends RefCounted
class_name DeferredRegister

var mod_id: String
var registry: Registry
var holders := {}


func _init(_mod_id: String, _registry: Registry):
	mod_id = _mod_id
	registry = _registry


func register(id: String, factory: Callable):
	var full_id = "%s:%s" % [mod_id, id]
	if registry.has(full_id):
		push_error("Duplicate ID: " + full_id)
		return null

	var entry = factory.call()
	registry.register(full_id, entry)
	holders[full_id] = entry
	return entry
