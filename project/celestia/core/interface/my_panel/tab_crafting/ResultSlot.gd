extends Button
class_name ResultSlot

signal slot_hovered(slot: Slot)
signal slot_unhovered()

@onready var slotTypeSprite: Sprite2D = $SlotType
@onready var itemSprite: Sprite2D = $ItemSprite
@onready var itemAmount: Label = $ItemAmount
@onready var inventory_tab = $"../../../InventoryTab"

# HANDLERS
func render_slot(slot_stack: ItemStack = ItemStack.EMPTY) -> void:
	if slot_stack.is_empty():
		slotTypeSprite.visible = true
		itemSprite.visible = false
		itemAmount.visible = false
	else:
		slotTypeSprite.visible = false
		itemSprite.texture = load(Celestia.ITEM_SPRITE_PATH % slot_stack.item.id.get_splited())
		itemSprite.visible = true
		if slot_stack.amount > 1:
			itemAmount.text = str(slot_stack.amount)
			itemAmount.visible = true
		else:
			itemAmount.visible = false


func _on_mouse_entered():
	emit_signal('slot_hovered', self)


func _on_mouse_exited():
	emit_signal('slot_unhovered')

# SIGNALS
func _on_gui_input(event: InputEvent):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if inventory_tab.cursor.cursor_stack.is_empty():
			inventory_tab.cursor.set_click($"../..".stacks['output'], -1)
