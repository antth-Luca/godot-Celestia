extends BaseStructure
class_name Bed

var stats: PropertyManager

# GODOT
func _init() -> void:
	stats = PropertyManager.create_manager({
		InitPropProviders.HEALTH: 3
	})

# MAIN
func on_interact(entity: LivingEntity) -> void:
	var hand_item: BaseItem = entity.inventory.get_hand().item
	if hand_item is AxeTool:
		try_destroy()
		await hand_item.set_cooldown(entity)
		entity.hand.is_interacting = false
	elif TimeManager.is_time_to_go_to_bed():
		ANIMATION.play('sleep')
		await entity.sleep()
		ANIMATION.stop()
		TEXTURE.frame = 0
		TimeManager.turn_the_day()


func try_destroy() -> void:
	var hp_prop: HealthProperty = stats.get_property(InitPropProviders.HEALTH)
	hp_prop.sub_health(1)
	if hp_prop.get_health() <= 0: queue_free()
