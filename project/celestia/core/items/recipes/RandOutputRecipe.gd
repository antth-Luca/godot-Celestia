extends BaseRecipe
class_name RandOutputRecipe

enum WorkstationType {
	MANUAL = 0,
	BENCH = 1,
	STAR_FORGE = 2,
	CLAY_FURNACE = 3,
	STONE_FURNACE = 4,
	STAR_CHANNEL = 5,
}

# SUPER
func get_workstation() -> WorkstationType:
	return super.get_workstation()


func set_workstation(station: WorkstationType) -> void:
	super.set_workstation(station)


func get_result() -> ItemStack:
	var loot_box: LootBox = _result.get_registered()
	var item_stacks: Array[ItemStack] = loot_box.get_sorted_output()
	return item_stacks.front()


func set_result(lootbox_holder: DeferredHolder) -> void:
	_result = lootbox_holder
