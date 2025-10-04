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
		try_destroy(1)
		await hand_item.set_cooldown(entity)
	else:
		var ui: WorldUI = entity.get_ui()
		ui.get_invent_panel()._on_craft_tab_button_pressed(workstation_key)
		ui.update_my_panel(false)
	entity.hand.is_interacting = false


func try_destroy(damage: int = 1) -> void:
	var hp_prop: HealthProperty = stats.get_property(InitPropProviders.HEALTH)
	hp_prop.sub_health(damage)
	if hp_prop.get_health() <= 0:
		# TODO: Adicionar LootBox de recursos da Fornalha.
		var loot_box: LootBox = InitLootBoxes.BUSH_DESTROY.get_registered()
		var item_stacks: Array[ItemStack] = loot_box.get_sorted_output()
		for stack in item_stacks:
			DroppedItemUtils.drop_item_in_position(stack, global_position)
		queue_free()
