extends BaseStructure
class_name CaveHole

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

# SUPER
func on_interact(entity: LivingEntity) -> void:
	var hp_prop: HealthProperty = structure_data.stats.get_property(InitPropProviders.HEALTH)
	if hp_prop.get_health() > 0:
		var hand_slot: BaseSlot = entity.inventory.get_hand()
		var hand_stack: ItemStack = hand_slot.stack
		if not hand_stack.is_empty() and hand_stack.item is BaseFertilizer:
			hand_stack.sub_amount(1, hand_slot)
			StructuresUtils.spawn_structure_in_position(InitStructures.FARMLAND.get_registered(), global_position, get_dimension())
			destroy(entity)
		return
	teleport_to_cave(entity)


func damage(final_dam: float, hit: HitData, hitbox_parent: Variant) -> void:
	var hp_prop: HealthProperty = structure_data.stats.get_property(InitPropProviders.HEALTH)
	if hp_prop.get_health() <= 0: return
	for output in InitLootBoxes.CAVE_HOLE_DIG.get_registered().get_sorted_output():
		DroppedItemUtils.drop_item_in_position(
			output,
			global_position, get_dimension()
		)
	super.damage(final_dam, hit, hitbox_parent)

# MAIN
func teleport_to_cave(entity: LivingEntity) -> void:
	var world: World = entity.get_tree().current_scene
	var target_dimension: CaveDimension = world.get_or_create_dimension(InitDimensions.CAVES)
	var source_dimension: SurfaceDimension = world.get_current_dimension()
	target_dimension.spawn_player(entity)
	# TODO: Remover player de source_dimension
