extends BaseItem
class_name CeramicBowlItem

# SUPER
# Handlers
func use(player: Player) -> void:
	var has_water: bool = player.get_tree().root.get_node('World').get_water_in_3x3_tiles(player.global_position)
	if has_water:
		var hand_slot: BaseSlot = player.inventory.get_hand()
		var hand_stack: ItemStack = hand_slot.stack
		hand_stack.sub_amount(1, hand_slot)
		player.inventory.add_item_to_backpack(ItemStack.new(InitItems.WATER_BOWL.get_registered(), 1))
