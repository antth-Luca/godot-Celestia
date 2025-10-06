extends BaseStructure
class_name CaveHole

const MAX_DROP_STONE: int = 2

# GODOT
func _init() -> void:
	structure_data = StructureData.new(
		[
			PickaxeTool.COMPARABLE_NAME
		],
		[
			InitMaterials.IRON.get_registered()
		],
		PropertyManager.create_manager({
			InitPropProviders.HEALTH: 4
		})
	)

# MAIN
func on_interact(entity: LivingEntity) -> void:
	# TODO: Implementar o teleporte para as cavernas.
	print_debug('Teleporto para as cavernas...')


func damage(final_dam: float, hit: HitData, hitbox_parent: Variant) -> void:
	super.damage(final_dam, hit, hitbox_parent)
	DroppedItemUtils.drop_item_in_position(
		ItemStack.new(InitItems.STONE.get_registered(), randi_range(1, MAX_DROP_STONE)),
		global_position
	)


func destroy(_attacker: LivingEntity) -> void:
	pass
