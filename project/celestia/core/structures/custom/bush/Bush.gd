extends BaseStructure
class_name Bush

var stats: PropertyManager

# GODOT
func _init() -> void:
	stats = PropertyManager.create_manager({
		InitPropProviders.HEALTH: 3
	})

# MAIN
func on_interact(entity: LivingEntity) -> void:
	var hand_item: BaseItem = entity.inventory.get_hand().stack.item
	var damage = 1
	if hand_item is AxeTool:
		damage = 3
	elif hand_item is PickaxeTool:
		damage = 1.5
	try_destroy(damage)
	if hand_item: await hand_item.set_cooldown(entity)
	entity.hand.is_interacting = false


func try_destroy(damage: int = 1) -> void:
	var hp_prop: HealthProperty = stats.get_property(InitPropProviders.HEALTH)
	hp_prop.sub_health(damage)
	if hp_prop.get_health() <= 0:
		var loot_box: LootBox = InitLootBoxes.BUSH_DESTROY.get_registered()
		var item_stacks: Array[ItemStack] = loot_box.get_sorted_output()
		for stack in item_stacks:
			DroppedItemUtils.drop_item_in_position(stack, global_position)
		queue_free()
