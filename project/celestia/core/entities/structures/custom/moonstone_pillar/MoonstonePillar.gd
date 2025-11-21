extends BaseStructure
class_name MoonstonePillar


# GODOT
func _init() -> void:
	structure_data = StructureData.new(
		[
			PickaxeTool.get_static_comparable_name()
		],
		[
			InitMaterials.IRON.get_registered()
		],
		PropertyManager.create_manager({
			InitPropProviders.HEALTH: 4
		})
	)

# MAIN
func destroy(attacker: LivingEntity) -> void:
	var loot_box: LootBox = InitLootBoxes.MOONSTONE_PILLAR_DESTROY.get_registered()
	var item_stacks: Array[ItemStack] = loot_box.get_sorted_output()
	for stack in item_stacks:
		DroppedItemUtils.drop_item_in_position(stack, global_position, get_dimension())
	super.destroy(attacker)
