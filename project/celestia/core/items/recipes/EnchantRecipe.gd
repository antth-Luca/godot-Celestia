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
	# TODO: Alterar a lógica aqui!
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
