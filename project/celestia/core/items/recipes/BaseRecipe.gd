extends Resource
class_name BaseRecipe

var id: ResourceLocation = ResourceLocation.EMPTY:
	set(new_id):
		if id != ResourceLocation.EMPTY and id.get_string() != new_id.get_string():
			push_warning('Recipe: Item ID already set. It cannot be changed after initialization.')
		id = new_id
var _workstation
var _ingredients: Array[Ingredient]
var _result

# GETTERS AND SETTERS
func get_workstation() -> Variant:
	return _workstation


func set_workstation(station) -> void:
	_workstation = station


func get_ingredients() -> Array[Ingredient]:
	return []


func add_ingredient(item_holder: DeferredHolder, amount: int) -> void:
	_ingredients.append(
		Ingredient.new(item_holder, amount)
	)


func get_result() -> ItemStack:
	return null


func set_result(result) -> void:
	_result = result

# MAIN
func matches(input: Array[ItemStack]) -> bool:
	if input.size() != _ingredients.size(): return false
	var used: Array[bool] = []
	used.resize(_ingredients.size())
	used.fill(false)
	for ingred in _ingredients:
		var matched := false
		for c in input.size():
			if not used[c] and ingred.item_holder.location.get_string() == input[c].item.id.get_string() and ingred.amount == input[c].amount:
				used[c] = true
				matched = true
				break
		if not matched: return false
	return true
