extends BaseStructure
class_name Bed

var stats: PropertyManager

# GODOT
func _init() -> void:
	stats = PropertyManager.create_manager({
		InitPropProviders.HEALTH: 3
	})


func _ready() -> void:
	var health_prop: HealthProperty = stats.get_property(InitPropProviders.HEALTH)
	# Health drained signal
	health_prop.connect('zero_health', Callable(self, 'destroy'))

# MAIN
func on_interact(entity: LivingEntity) -> void:
	var hand_item: BaseItem = entity.inventory.get_hand().item
	if hand_item is AxeTool:
		stats.get_property(InitPropProviders.HEALTH).sub_health(1)
		await hand_item.set_cooldown(entity)
		entity.hand.is_interacting = false
	elif TimeManager.is_time_to_go_to_bed():
		ANIMATION.play('sleep')
		await entity.sleep()
		ANIMATION.stop()
		TEXTURE.frame = 0
		TimeManager.turn_the_day()


func destroy() -> void:
	queue_free()
