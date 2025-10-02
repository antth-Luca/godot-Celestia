extends BaseRecipe
class_name WithReturnRecipe

enum WorkstationType {
	MANUAL,
	BENCH,
	CLAY_FURNACE,
	STONE_FURNACE,
	STAR_CHANNEL,
	STAR_FORGE
}

var _returns: Array[Ingredient]
var _damage_p_return: Array[int]

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


func set_result(result: Ingredient) -> void:
	super.set_result(result)

# GETTERS AND SETTERS
func get_returns() -> Array[ItemStack]:
	if _returns.size() != _damage_p_return.size(): return []
	var stacks_return: Array[ItemStack] = []
	for c in _returns.size():
		var stack := ItemStack.new(_returns[c].item_holder.get_registered(), _returns[c].amount)
		stack.item.consome_durability(_damage_p_return[c], null)
	return stacks_return


func add_return(item_holder: DeferredHolder, amount: int, return_damage: int) -> void:
	_returns.append(Ingredient.new(item_holder, amount))
	_damage_p_return.append(return_damage)
