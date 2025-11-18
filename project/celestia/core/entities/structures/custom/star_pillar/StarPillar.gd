extends BaseStructure
class_name StarPillar

const MAX_ENERGY_GEN: float = 20

var stored_energy: float

# GODOT
func _init() -> void:
	structure_data = StructureData.new(
		[
			PickaxeTool.get_static_comparable_name()
		],
		[
			InitMaterials.ASTRONITE.get_registered()
		],
		PropertyManager.create_manager({
			InitPropProviders.HEALTH: 3
		})
	)

# SUPER
# Main
func on_interact(entity: LivingEntity) -> void:
	var text_of_pillar: String = '- %s -\n%s: %s\n%s: %s/%s' % [
		tr(Celestia.TRANSLATION_KEY_BASES.STRUCTURE % id.path),
		tr(Celestia.TRANSLATION_KEY_BASES.STRUCTURE_SECTION % 'storage'), stored_energy,
		tr(Celestia.TRANSLATION_KEY_BASES.STRUCTURE_SECTION % 'current_generation'),
		get_generate_energy(), MAX_ENERGY_GEN
	]
	var ui: WorldUI = entity.get_ui()
	ui.get_invent_panel()._on_craft_tab_button_pressed(-1, text_of_pillar)
	ui.update_my_panel(false)


func destroy(attacker: LivingEntity) -> void:
	# TODO: Adicionar drop de itens.
	super.destroy(attacker)

# GETTERS AND SETTERS
func get_generate_energy() -> float:
	return 0
