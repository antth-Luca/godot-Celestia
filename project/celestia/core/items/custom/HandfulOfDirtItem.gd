extends BaseItem
class_name HandfulOfDirtItem

# SUPER
# Handlers
func use(player: Player) -> void:
	var has_water: bool = player.get_tree().root.get_node('World').get_water_in_3x3_tiles(player.global_position)
	if has_water:
		var hand_slot: BaseSlot = player.inventory.get_hand()
		var stack: ItemStack = hand_slot.stack
		stack.amount -= 1
		if stack.amount <= 0:
			break_item(hand_slot)
		else:
			hand_slot.render_slot()
		player.inventory.add_item_to_backpack(ItemStack.new(InitItems.HANDFUL_OF_CLAY.get_registered(), 1))
