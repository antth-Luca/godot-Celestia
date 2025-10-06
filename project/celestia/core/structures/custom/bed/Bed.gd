extends BaseStructure
class_name Bed

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
		await hand_item.set_cooldown(entity)
		entity.hand.is_interacting = false
	elif TimeManager.is_time_to_go_to_bed():
		ANIMATION.play('sleep')
		await entity.sleep()
		ANIMATION.stop()
		TEXTURE.frame = 0
		TimeManager.turn_the_day()


func destroy(attacker: LivingEntity) -> void:
	# TODO: Adicionar drop de matérias-prima.
	super.destroy(attacker)
