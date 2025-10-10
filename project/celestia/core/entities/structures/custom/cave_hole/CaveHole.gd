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
func on_interact(_entity: LivingEntity) -> void:
	var hp_prop: HealthProperty = structure_data.stats.get_property(InitPropProviders.HEALTH)
	if hp_prop.get_health() > 0: return
	print_debug('Teleporto para as cavernas...')  # TODO: Implementar o teleporte para as cavernas.


func damage(final_dam: float, hit: HitData, hitbox_parent: Variant) -> void:
	var hp_prop: HealthProperty = structure_data.stats.get_property(InitPropProviders.HEALTH)
	if hp_prop.get_health() <= 0: return
	DroppedItemUtils.drop_item_in_position(
		ItemStack.new(InitItems.STONE.get_registered(), randi_range(1, MAX_DROP_STONE)),
		global_position
	)
	super.damage(final_dam, hit, hitbox_parent)


func destroy(_attacker: LivingEntity) -> void:
	pass
