extends DeferredRegister
class_name RecipeDeferredRecipe

var _per_workstation: Dictionary[WorkstationTypes, Array] = {}
var _per_ingredient: Dictionary[DeferredHolder, Array] = {}


func add_entry(path: String, factory: Callable) -> DeferredHolder:
	var location = ResourceLocation.new(mod_id, path)
	if _entries.has(location):
		push_error("DeferredRegister: Duplicate ID %s. " % location.get_string())
		return null

	_entries[location] = factory
	return DeferredHolder.new(registry.REGISTRY_TYPE, location)


func register() -> void:
	for location in _entries:
		registry.register(location, _entries[location])
