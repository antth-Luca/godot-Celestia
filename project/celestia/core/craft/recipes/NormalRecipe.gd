extends Resource
class_name NormalRecipe

enum WORKBENCHS {
	MANUAL,
	TABLE,
	CLAY_OVEN,
	STONE_FURNACE,
	STAR_CHANNEL,
	STAR_FORGE
}

class Ingredient:
	var item_id: ResourceLocation
	var amount: int

# Recipe
var id: ResourceLocation = ResourceLocation.EMPTY:
	set(new_id):
		if id != ResourceLocation.EMPTY and id.get_string() != new_id.get_string():
			push_warning('BaseItem: Item ID already set. It cannot be changed after initialization.')
		id = new_id
var _result: ItemStack
var ingredients: Array[Ingredient]
var worbench: WORKBENCHS

# GETTERS AND SETTERS
func get_result() -> Variant:
	return _result.duplicate()


func set_result(new_result: Variant) -> void:
	_result = new_result

# MAIN
func matches(input: Array[ItemStack]) -> bool:
	if input.size() != ingredients.size(): return false
	for inp in input:
		for ing in ingredients:
			if inp.item.id.get_string() != ing.item_id.get_string() or inp.amount < ing.amount:
				return false
	return true
