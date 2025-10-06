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
	if hand_item: await hand_item.set_cooldown(entity)
	entity.hand.is_interacting = false
