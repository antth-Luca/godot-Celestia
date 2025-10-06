extends BaseStructure
class_name StoneFurnace

const workstation_key: int = SmeltingRecipe.WorkstationType.STONE_FURNACE

var stats: PropertyManager

# GODOT
func _init() -> void:
	stats = PropertyManager.create_manager({
		InitPropProviders.HEALTH: 3
	})

# MAIN
func on_interact(entity: LivingEntity) -> void:
	var hand_item: BaseItem = entity.inventory.get_hand().stack.item
	if hand_item is PickaxeTool:
		await hand_item.set_cooldown(entity)
	else:
		var ui: WorldUI = entity.get_ui()
		ui.get_invent_panel()._on_craft_tab_button_pressed(workstation_key)
		ui.update_my_panel(false)
	entity.hand.is_interacting = false
