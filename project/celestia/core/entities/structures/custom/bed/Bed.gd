extends BaseStructure
class_name Bed

# GODOT
func _init() -> void:
	structure_data = StructureData.new(
		[
			AxeTool.get_static_comparable_name()
		],
		[
			InitMaterials.IRON.get_registered()
		],
		PropertyManager.create_manager({
			InitPropProviders.HEALTH: 3
		})
	)

# MAIN
func on_interact(entity: LivingEntity) -> void:
	if TimeManager.is_time_to_go_to_bed():
		ANIMATION.play('sleep')
		await entity.sleep()
		ANIMATION.stop()
		TEXTURE.frame = 0
		TimeManager.turn_the_day()


func destroy(attacker: LivingEntity) -> void:
	# TODO: Adicionar drop de matérias-prima.
	super.destroy(attacker)
