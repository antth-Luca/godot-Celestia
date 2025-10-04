extends BaseRecipe
class_name SmeltingRecipe

enum WorkstationType {
	CLAY_FURNACE = 3,
	STONE_FURNACE = 4
}

var melting_point: int:
	set(new_point):
		melting_point = max(new_point, 1)

# SUPER
func get_workstation() -> WorkstationType:
	return super.get_workstation()


func set_workstation(station: WorkstationType) -> void:
	super.set_workstation(station)


func get_result() -> ItemStack:
	return ItemStack.new(
		_result.item_holder.get_registered(),
		_result.amount
	)


func matches(input: Array[ItemStack]) -> bool:
	if input.size() - 1 != _ingredients.size(): return false
	var simple_ingred: Ingredient = _ingredients.front()
	var simple_input: ItemStack = input.front()
	if simple_ingred.item_holder.location.get_string() == simple_input.item.id.get_string() and simple_ingred.amount == simple_input.amount:
		var fuel_stack: ItemStack = input.back()
		var available_energy: int = fuel_stack.item.energy * fuel_stack.amount
		if not available_energy < melting_point:
			return true
	return false

# MAIN
func get_consumed_fuel_stack(current_fuel_stack) -> ItemStack:
	var available_energy: int = current_fuel_stack.item.energy * current_fuel_stack.amount
	return ItemStack.new(
		current_fuel_stack.item,
		 int((available_energy - melting_point) / current_fuel_stack.item.energy)
	)
