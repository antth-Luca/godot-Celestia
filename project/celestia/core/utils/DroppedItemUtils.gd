extends Node

func drop_item_in_position(stack: ItemStack, pos: Vector2) -> void:
	# Drops an item in a specific position
	var dropped_item = preload(Celestia.DROPPED_ITEM_SCENE_PATH)
	var drop = dropped_item.instantiate()
	drop.initialize(stack)
	get_tree().root.add_child(drop)
	drop.global_position = pos
	drop.set_delay_to_collect()


func drop_item_entity_foot(stack: ItemStack, entity: LivingEntity) -> void:
	# Drops an item at the entity's feet
	var at_pos = entity.global_position
	drop_item_in_position(stack, at_pos)
