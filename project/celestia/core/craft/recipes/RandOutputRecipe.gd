extends Resource
class_name RandOutputRecipe

var id: ResourceLocation = ResourceLocation.EMPTY:
	set(new_id):
		if id != ResourceLocation.EMPTY and id.get_string() != new_id.get_string():
			push_warning('NormalRecipe: Item ID already set. It cannot be changed after initialization.')
		id = new_id
var _random_result: DeferredHolder
var _ingredients: Array[Array] = []  # -> [item_holder, amount]
var worbench: WorkstationTypes

# GETTERS AND SETTERS
func get_result() -> ItemStack:
	var loot_box: LootBox = _random_result.get_registered()
	var item_stacks: Array[ItemStack] = loot_box.get_sorted_output()
	return item_stacks.front()
	


func set_result(lootbox_holder: DeferredHolder) -> void:
	_random_result = lootbox_holder


func get_ingredients() -> Array:
	return _ingredients


func add_ingredient(ingredient_item: DeferredHolder, ingredient_amount: int) -> void:
	_ingredients.append([
		ingredient_item,
		ingredient_amount
	])

# MAIN
func matches(input: Array[ItemStack]) -> bool:
	if input.size() != _ingredients.size(): return false
	for inp in input:
		for ing in _ingredients:
			if inp.item.id.get_string() != ing.front().location.get_string() or inp.amount < ing.back():
				return false
	return true
