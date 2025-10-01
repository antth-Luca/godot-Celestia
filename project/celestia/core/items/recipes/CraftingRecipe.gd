extends BaseRecipe
class_name CraftingRecipe

enum WorkstationType {
	MANUAL,
	BENCH,
	STAR_FORGE
}

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
