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
	var hand_item: BaseItem = entity.inventory.get_hand().stack.item
	if hand_item:
		var damage
		if hand_item is AxeTool:
			damage = 1.5
		elif hand_item is PickaxeTool:
			damage = 1
		try_destroy(damage)
		await hand_item.set_cooldown(entity)
		entity.hand.is_interacting = false
	elif TimeManager.is_time_to_go_to_bed():
		ANIMATION.play('sleep')
		await entity.sleep()
		ANIMATION.stop()
		TEXTURE.frame = 0
		TimeManager.turn_the_day()


func try_destroy(damage: int) -> void:
	var hp_prop: HealthProperty = stats.get_property(InitPropProviders.HEALTH)
	hp_prop.sub_health(damage)
	if hp_prop.get_health() <= 0:
		# TODO: Adicionar drop de matérias-prima.
		queue_free()
