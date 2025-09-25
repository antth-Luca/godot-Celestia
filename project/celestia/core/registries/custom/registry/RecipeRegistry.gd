extends Registry
class_name RecipeRegistry

static var REGISTRY_TYPE: String = 'Recipes'

var _per_workstation: Dictionary[WorkstationTypes, Array] = {}
var _per_ingredient: Dictionary[DeferredHolder, Array] = {}


func register(id: ResourceLocation, entry: Callable) -> void:
	super.register(id, entry)
	# Get recipe
	var recipe = entry.call()
	if not recipe:
		push_error('RecipeRegistry: Recipe %s is null' % id.get_string())
		return
	# Per workstation
	if not _per_workstation.has(recipe.workstation):
		_per_workstation[recipe.workstation] = []
	_per_workstation[recipe.workstation].append(id)
	# Per ingredient
	for ing in recipe.get_ingredients():
		if not _per_ingredient.has(ing):
			_per_ingredient[ing] = []
		_per_ingredient[ing].append(id)
