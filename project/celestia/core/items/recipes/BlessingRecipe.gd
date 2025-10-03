extends BaseRecipe
class_name BlessingRecipe

enum WorkstationType {
	STAR_CHANNEL = 5
}

# SUPER
func get_workstation() -> WorkstationType:
	return super.get_workstation()


func set_workstation(station: WorkstationType) -> void:
	super.set_workstation(station)


func add_ingredient(item_holder: DeferredHolder, amount: int) -> void:
	if not _ingredients.is_empty():
		_ingredients.clear()
	super.add_ingredient(item_holder, amount)


func get_result() -> ItemStack:
	return ItemStack.new(
		_result.item_holder.get_registered(),
		_result.amount
	)


func set_result(result: Ingredient) -> void:
	super.set_result(result)
