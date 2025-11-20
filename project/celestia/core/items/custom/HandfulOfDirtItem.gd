extends BaseItem
class_name HandfulOfDirtItem

# SUPER
# Handlers
func use(player: Player) -> void:
	var dimension: Node2D = player.get_dimension()
	var has_water: bool = dimension.get_water_in_3x3_tiles(player.global_position) if dimension.has_method('get_water_in_3x3_tiles') else false
	if has_water:
		var hand_slot: BaseSlot = player.inventory.get_hand()
		var hand_stack: ItemStack = hand_slot.stack
		hand_stack.sub_amount(1, hand_slot)
		player.inventory.add_item_to_backpack(ItemStack.new(InitItems.HANDFUL_OF_CLAY.get_registered(), 1))
