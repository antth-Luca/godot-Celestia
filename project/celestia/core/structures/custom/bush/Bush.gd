extends BaseStructure
class_name Bush

# GODOT
func _init() -> void:
	structure_data = StructureData.new(
		[
			AxeTool.COMPARABLE_NAME,
			PickaxeTool.COMPARABLE_NAME,
			SwordTool.COMPARABLE_NAME
		],
		[
			InitMaterials.STONE.get_registered()
		],
		PropertyManager.create_manager({
			InitPropProviders.HEALTH: 1
		})
	)

# MAIN
func on_interact(entity: LivingEntity) -> void:
	print_debug('Interagiu com a bush')
	var hit := HitData.new(
		entity,
		HitData.PRIMITIVE_TYPE.PHYSIC,
		HitData.SPECIALIZED_TYPE.NONE
	)
	damage(.4, hit, null)


func destroy(attacker: LivingEntity) -> void:
	var loot_box: LootBox = InitLootBoxes.BUSH_DESTROY.get_registered()
	var item_stacks: Array[ItemStack] = loot_box.get_sorted_output()
	for stack in item_stacks:
		DroppedItemUtils.drop_item_in_position(stack, global_position)
	super.destroy(attacker)
