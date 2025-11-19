extends BaseStructure
class_name StarForge

enum EnergyType { STAR, LUNAR }

const workstation_key: int = EnchantRecipe.WorkstationType.STAR_FORGE

var pillar_dict: Dictionary[EnergyType, Array] = { EnergyType.STAR: [], EnergyType.LUNAR: [] }

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
			InitPropProviders.HEALTH: 3
		})
	)

# SUPER
# Main
func add_highlight() -> void:
	super.add_highlight()
	for key in pillar_dict.keys():
		for pillar in pillar_dict[key]:
			pillar._set_outline(true)


func remove_highlight() -> void:
	super.remove_highlight()
	for key in pillar_dict.keys():
		for pillar in pillar_dict[key]:
			pillar._set_outline(false)


func on_interact(entity: LivingEntity) -> void:
	var hand_slot: BaseSlot = entity.inventory.get_hand()
	var hand_item: BaseItem = hand_slot.stack.item
	# Crafting
	if not hand_item is LinkingStaffItem:
		var ui: WorldUI = entity.get_ui()
		ui.get_invent_panel().get_craft_tab().forge.pillar_dict = pillar_dict
		ui.get_invent_panel()._on_craft_tab_button_pressed(workstation_key)
		ui.update_my_panel(false)
		return
	# Linking
	if hand_item.link:
		for key in pillar_dict.keys():
			var idx: int = pillar_dict[key].find(hand_item.link)
			if idx > -1:
				unregister_pillar(key, idx)
				hand_item.link = null
				return
		register_pillar(hand_item.link)
		hand_item.link = null
		hand_item.consume_durability(1, hand_slot)


func destroy(attacker: LivingEntity) -> void:
	# TODO: Adicionar drop de itens.
	super.destroy(attacker)

# MAIN
func register_pillar(pillar: BaseStructure) -> void:
	pillar._set_outline(true)
	pillar_dict[pillar.energy_type].append(pillar)
	pillar.forge_list.append(self)


func unregister_pillar(dict_key: int, index: int) -> void:
	var pillar: BaseStructure = pillar_dict[dict_key][index]
	pillar._set_outline(false)
	pillar.forge_list.erase(self)
	pillar_dict[dict_key].remove_at(index)
