extends BaseRecipe
class_name EnchantRecipe

enum WorkstationType {
	STAR_FORGE = 2
}

var enchantment: BaseEnchantment

# SUPER
func get_workstation() -> WorkstationType:
	return super.get_workstation()


func set_workstation(station: WorkstationType) -> void:
	super.set_workstation(station)


func set_result(_result_disuse) -> void:
	return

# GETTERS AND SETTERS
func get_enchanted_result(input_tool: BaseTool) -> ItemStack:
	input_tool.add_enchantment(enchantment)
	return ItemStack.new(input_tool)

# MAIN
func matches(input: Array[ItemStack]) -> bool:
	if input.size() != _ingredients.size() + 1: return false
	var target_item = input.front().item
	if not enchantment.check_applicability(target_item): return false
	var used: Array[bool] = []
	used.resize(_ingredients.size())
	used.fill(false)
	for i in _ingredients.size():
		var ingred: Ingredient = _ingredients[i]
		var matched := false
		for c in range(1, input.size()):
			var input_stack: ItemStack = input[c]
			if not used[i] and ingred.item_holder.location.get_string() == input_stack.item.id.get_string() and ingred.amount == input_stack.amount:
				used[i] = true
				matched = true
				break
		if not matched: return false
	return enchantment.check_compability(target_item)
