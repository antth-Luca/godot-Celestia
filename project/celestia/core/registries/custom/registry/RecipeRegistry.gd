extends Registry
class_name RecipeRegistry

static var REGISTRY_TYPE: String = 'Recipes'

var _per_workstation: Dictionary[int, Array] = {}  # Dictionary[WorkstationTypes, Array[recipe:ResourceLocation]]
var _per_ingredient: Dictionary[ResourceLocation, Array] = {}  # Dictionary[item:ResourceLocation, Array[recipe:ResourceLocation]]


func register(id: ResourceLocation, entry: Callable) -> void:
	super.register(id, entry)
	# Get recipe
	var recipe: BaseRecipe = entry.call()
	if not recipe:
		push_error('RecipeRegistry: Recipe %s is null' % id.get_string())
		return
	# Per workstation
	if not _per_workstation.has(recipe.get_workstation()):
		_per_workstation[recipe.get_workstation()] = []
	_per_workstation[recipe.get_workstation()].append(id)
	# Per ingredient
	for ingred in recipe.get_ingredients():
		var location = ingred.item_holder.location
		if not _per_ingredient.has(location):
			_per_ingredient[location] = []
		_per_ingredient[location].append(id)
