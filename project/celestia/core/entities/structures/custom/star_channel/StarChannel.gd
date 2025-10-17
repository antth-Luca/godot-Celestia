extends BaseStructure
class_name StarChannel

const workstation_key: int = BlessingRecipe.WorkstationType.STAR_CHANNEL

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
			InitPropProviders.HEALTH: 3
		})
	)

# MAIN
func on_interact(entity: LivingEntity) -> void:
	var ui: WorldUI = entity.get_ui()
	ui.get_invent_panel()._on_craft_tab_button_pressed(workstation_key)
	ui.update_my_panel(false)


func destroy(attacker: LivingEntity) -> void:
	# TODO: Adicionar drop de itens.
	super.destroy(attacker)
