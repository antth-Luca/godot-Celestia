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
	var hand_item: BaseItem = entity.inventory.get_hand().item
	try_destroy(3 if hand_item is AxeTool else 1)
	await hand_item.set_cooldown(entity)
	entity.hand.is_interacting = false


func try_destroy(damage: int = 1) -> void:
	var hp_prop: HealthProperty = stats.get_property(InitPropProviders.HEALTH)
	hp_prop.sub_health(damage)
	if hp_prop.get_health() <= 0: queue_free()
