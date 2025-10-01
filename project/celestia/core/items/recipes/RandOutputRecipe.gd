extends BaseRecipe
class_name RandOutputRecipe

enum WorkstationType {
	MANUAL,
	BENCH,
	CLAY_FURNACE,
	STONE_FURNACE,
	STAR_CHANNEL,
	STAR_FORGE
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
