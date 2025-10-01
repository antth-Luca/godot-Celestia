extends InventSlot
class_name InventPocketSlot

signal slot_rendered(stack: ItemStack)
signal slot_cleaned()

# SUPER
# Handlers
func render_slot() -> void:
	super.render_slot()
	var slot_index: int = get_index()
	if slot_index == InventoryManager.MIN_SLOTS and player:
		player.hand.ITEM_HAND_TEXTURE.texture = itemSprite.texture
	if slot_index in [0, 1, 2, 3]:
		emit_signal('slot_rendered', stack)


func clear_slot() -> void:
	super.clear_slot()
	var slot_index: int = get_index()
	if slot_index == InventoryManager.MIN_SLOTS and player:
		player.hand.ITEM_HAND_TEXTURE.texture = null
	if slot_index in [0, 1, 2, 3]:
		emit_signal('slot_cleaned')
