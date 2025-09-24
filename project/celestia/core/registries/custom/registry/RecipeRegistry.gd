extends Registry
class_name RecipeRegistry

static var REGISTRY_TYPE: String = 'Recipes'

var _per_workstation: Dictionary[WorkstationTypes, Array] = {}
var _per_ingredient: Dictionary[DeferredHolder, Array] = {}


func register(id: ResourceLocation, entry: Callable) -> void:
	super.register(id, entry)
