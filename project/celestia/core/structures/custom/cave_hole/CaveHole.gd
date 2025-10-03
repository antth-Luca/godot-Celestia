extends BaseStructure
class_name CaveHole

const MAX_DROP_STONE: int = 2

var stats: PropertyManager

# GODOT
func _init() -> void:
	stats = PropertyManager.create_manager({
		InitPropProviders.HEALTH: 4
	})

# MAIN
func on_interact(entity: LivingEntity) -> void:
	var hand_item: BaseItem = entity.inventory.get_hand().stack.item
	if hand_item is PickaxeTool:
		try_destroy(1)
		await hand_item.set_cooldown(entity)
		entity.hand.is_interacting = false
	else:
		print_debug('Teleporto para as cavernas...')  # TODO: Implementar o teleporte para as cavernas.


func try_destroy(damage: int = 1) -> void:
	var hp_prop: HealthProperty = stats.get_property(InitPropProviders.HEALTH)
	if hp_prop.get_health() > 0:
		hp_prop.sub_health(damage)
		DroppedItemUtils.drop_item_in_position(
			ItemStack.new(InitItems.STONE.get_registered(), randi_range(1, MAX_DROP_STONE)),
			global_position
		)
