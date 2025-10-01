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
	for inp in input:
		for ing in _ingredients:
			if inp.item.id.get_string() != ing.item_holder.location.get_string() or inp.amount < ing.amount:
				return false
	return true
