extends BaseStructure
class_name StarPillar

const MAX_ENERGY_GEN: float = 5

var stored_energy: float
var forge_list: Array[BaseStructure]

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
func add_highlight() -> void:
	super.add_highlight()
	for forge in forge_list:
		forge._set_outline(true)


func remove_highlight() -> void:
	super.remove_highlight()
	for forge in forge_list:
		forge._set_outline(false)


func on_interact(entity: LivingEntity) -> void:
	var hand_stack: ItemStack = entity.inventory.get_hand().stack
	# Informations
	if not hand_stack.item is LinkingStaffItem:
		var text_of_pillar: String = '- %s -\n%s: %s\n%s: %s/%s\n%s: %s/%s' % [
			tr(Celestia.TRANSLATION_KEY_BASES.STRUCTURE % id.path),
			tr(Celestia.TRANSLATION_KEY_BASES.STRUCTURE_SECTION % 'storage'), stored_energy,
			tr(Celestia.TRANSLATION_KEY_BASES.STRUCTURE_SECTION % 'current_generation'), get_generate_energy(),
			tr(Celestia.TRANSLATION_KEY_BASES.SECTION_TITLE % 'seconds'),
			tr(Celestia.TRANSLATION_KEY_BASES.STRUCTURE_SECTION % 'max_generation'), MAX_ENERGY_GEN,
			tr(Celestia.TRANSLATION_KEY_BASES.SECTION_TITLE % 'seconds'),
		]
		var ui: WorldUI = entity.get_ui()
		ui.get_invent_panel()._on_craft_tab_button_pressed(-1, text_of_pillar)
		ui.update_my_panel(false)
		return
	# Linking
	hand_stack.item.link = self


func destroy(attacker: LivingEntity) -> void:
	# TODO: Adicionar drop de itens.
	super.destroy(attacker)

# GETTERS AND SETTERS
func get_generate_energy() -> float:
	var time: float = TimeManager.time_counter
	var start: int = TimeManager.TimeOfDay.MORNING.front()
	var end: int = TimeManager.TimeOfDay.AFTERNOON.back()
	if time < start or time > end: return 0
	var t: float = (time - start) / (end - start)
	return snappedf(remap(t, 0, 1, MAX_ENERGY_GEN, 1), 0.01)

# HANDLERS
func _on_generation_timer_timeout() -> void:
	stored_energy += get_generate_energy()
