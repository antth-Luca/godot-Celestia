extends BaseStructure
class_name StarForge

const workstation_key: int = EnchantRecipe.WorkstationType.STAR_FORGE

var pillar_list: Array[BaseStructure]

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
	for pillar in pillar_list:
		pillar._set_outline(true)


func remove_highlight() -> void:
	super.remove_highlight()
	for pillar in pillar_list:
		pillar._set_outline(false)


func on_interact(entity: LivingEntity) -> void:
	var hand_slot: BaseSlot = entity.inventory.get_hand()
	var hand_item: BaseItem = hand_slot.stack.item
	# Crafting
	if not hand_item is LinkingStaffItem:
		var ui: WorldUI = entity.get_ui()
		ui.get_invent_panel()._on_craft_tab_button_pressed(workstation_key)
		ui.update_my_panel(false)
		return
	# Linking
	if hand_item.link:
		var idx: int = pillar_list.find(hand_item.link)
		if idx > -1:
			unregister_pillar(idx)
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
	pillar_list.append(pillar)
	pillar.forge_list.append(self)


func unregister_pillar(index: int) -> void:
	var pillar: BaseStructure = pillar_list[index]
	pillar._set_outline(false)
	pillar.forge_list.erase(self)
	pillar_list.remove_at(index)
