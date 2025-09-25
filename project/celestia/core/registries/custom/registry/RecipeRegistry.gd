extends Registry
class_name RecipeRegistry

static var REGISTRY_TYPE: String = 'Recipes'

var _per_workstation: Dictionary[int, Array] = {}  # :Dictionary[WorkstationTypes, Array]
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
	for ingred_array in recipe.get_ingredients():
		var ingred = ingred_array.front()
		if not _per_ingredient.has(ingred):
			_per_ingredient[ingred] = []
		_per_ingredient[ingred].append(id)
