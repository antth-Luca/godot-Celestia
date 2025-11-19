extends BaseRecipe
class_name CraftingRecipe

enum WorkstationType {
	MANUAL = 0,
	BENCH = 1,
	STAR_FORGE = 2
}

var required_star_energy: int = 0:
	set(new_point):
		required_star_energy = max(new_point, 0)
var required_lunar_energy: int = 0:
	set(new_lunar):
		required_lunar_energy = max(new_lunar, 0)

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
