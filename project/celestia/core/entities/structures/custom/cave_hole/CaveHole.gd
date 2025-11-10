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

# MAIN
func on_interact(_entity: LivingEntity) -> void:
	var hp_prop: HealthProperty = structure_data.stats.get_property(InitPropProviders.HEALTH)
	if hp_prop.get_health() > 0:
		print_debug('Farmland spawn...')  # TODO: Implementar a transformação em Terra Arada.
		return
	print_debug('Teleporto para as cavernas...')  # TODO: Implementar o teleporte para as cavernas.


func damage(final_dam: float, hit: HitData, hitbox_parent: Variant) -> void:
	var hp_prop: HealthProperty = structure_data.stats.get_property(InitPropProviders.HEALTH)
	if hp_prop.get_health() <= 0: return
	for output in InitLootBoxes.CAVE_HOLE_DIG.get_registered().get_sorted_output():
		DroppedItemUtils.drop_item_in_position(
			output,
			global_position
		)
	super.damage(final_dam, hit, hitbox_parent)


func destroy(_attacker: LivingEntity) -> void:
	pass
